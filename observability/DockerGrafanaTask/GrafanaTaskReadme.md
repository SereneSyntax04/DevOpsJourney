
# 🐳 Observability Mini Project 

## What you’ll end up with

* Node.js app **inside Docker**
* OpenTelemetry **inside Docker**
* Metrics + Logs + Traces → **Grafana Cloud**
* Destroy everything with **one command**

---

## 🧱 STEP 0: Prerequisites (Only This)

Install:

* **Docker Desktop**

Verify:

```bash
docker --version
docker compose version
```

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/1.png" width="300"> </div>

That’s it. No Node. No npm. No pollution.

---

## 🧱 STEP 1: Create Grafana Cloud Account (Free)

(Same as before, but repeating clearly)

1. Go to **grafana.com**
2. Get **Grafana Cloud → Free**
3. Create stack → name it anything
4. Go to **Connections → OpenTelemetry**

Save these 3 things (critical):

```
OTLP_ENDPOINT
GRAFANA_INSTANCE_ID
GRAFANA_API_KEY
```

Example endpoint:

```
https://otlp-gateway-prod-ap-south-1.grafana.net/otlp
```

---

## 🧱 STEP 2: Project Structure (Very Clean)

Create a folder anywhere:

```bash
mkdir observability-docker
cd observability-docker
```

Structure will be:

```
observability-docker/
│
├── app/
│   ├── index.js
│   ├── otel.js
│   ├── package.json
│   └── Dockerfile
│
└── docker-compose.yml
```

---

## 🧱 STEP 3: Node App (Inside Container)

### `app/package.json`

```json
{
  "name": "observability-demo",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node -r ./otel.js index.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pino": "^8.17.0",
    "pino-http": "^9.0.0",

    "@opentelemetry/api": "^1.7.0",
    "@opentelemetry/sdk-node": "^0.46.0",
    "@opentelemetry/auto-instrumentations-node": "^0.46.0",
    "@opentelemetry/exporter-trace-otlp-http": "^0.46.0",
    "@opentelemetry/exporter-metrics-otlp-http": "^0.46.0",
    "@opentelemetry/resources": "^1.7.0"
  }
}
```

---

### `app/index.js`

```js
const express = require("express");
const pinoHttp = require("pino-http");

const app = express();
app.use(pinoHttp());

app.get("/", (req, res) => {
  res.send("Hello from Docker Observability 👀");
});

app.get("/slow", async (req, res) => {
  await new Promise(r => setTimeout(r, 2000));
  res.send("Slow request 🐌");
});

app.listen(3000, () => {
  console.log("App running on port 3000");
});
```

---

### `app/otel.js`

```js
const { NodeSDK } = require("@opentelemetry/sdk-node");
const { getNodeAutoInstrumentations } = require("@opentelemetry/auto-instrumentations-node");
const { OTLPTraceExporter } = require("@opentelemetry/exporter-trace-otlp-http");
const { OTLPMetricExporter } = require("@opentelemetry/exporter-metrics-otlp-http");
const { Resource } = require("@opentelemetry/resources");

const authHeader = Buffer.from(
  process.env.GRAFANA_INSTANCE_ID + ":" + process.env.GRAFANA_API_KEY
).toString("base64");

const sdk = new NodeSDK({
  resource: new Resource({
    "service.name": "node-docker-observability"
  }),
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT,
    headers: { Authorization: `Basic ${authHeader}` }
  }),
  metricExporter: new OTLPMetricExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT,
    headers: { Authorization: `Basic ${authHeader}` }
  }),
  instrumentations: [getNodeAutoInstrumentations()]
});

sdk.start();
```

---

## 🧱 STEP 4: Dockerfile (Node App Container)

### `app/Dockerfile`

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package.json .
RUN npm install --only=production

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

👉 Lightweight, clean, disposable.

---

## 🧱 STEP 5: Docker Compose (THIS IS THE CORE)

### `docker-compose.yml`

```yaml
version: "3.9"

services:
  app:
    build: ./app
    ports:
      - "3000:3000"
    environment:
      OTEL_EXPORTER_OTLP_ENDPOINT: ${OTEL_EXPORTER_OTLP_ENDPOINT}
      GRAFANA_INSTANCE_ID: ${GRAFANA_INSTANCE_ID}
      GRAFANA_API_KEY: ${GRAFANA_API_KEY}
```

---

## 🧱 STEP 6: Environment Variables (Outside Docker)

Create `.env` file (same folder as compose):

```env
OTEL_EXPORTER_OTLP_ENDPOINT=https://<your-grafana-otlp-endpoint>/otlp
GRAFANA_INSTANCE_ID=xxxx
GRAFANA_API_KEY=xxxx
```

📌 `.env` is read automatically by Docker Compose.

---

## 🧱 STEP 7: Build & Run (One Command)

```bash
docker compose up --build
```

You’ll see:

```
App running on port 3000
```

---

## 🧱 STEP 8: Generate Traffic

Browser or curl:

```bash
curl http://localhost:3000
curl http://localhost:3000/slow
```

Hit `/slow` multiple times.

---

## 🧱 STEP 9: Observe in Grafana Cloud

### Metrics 📊

Grafana → **Explore → Metrics**

* http.server.request.duration
* http.server.request.count
* CPU, memory

### Logs 🧾

Grafana → **Explore → Logs**

* JSON logs
* request path, latency, status

### Traces 🧵

Grafana → **Explore → Traces**

* Click `/slow`
* See 2s delay clearly

This is **real observability**, not textbook nonsense.

---

## 🧱 STEP 10: Add Alert 🚨

Grafana → **Alerting**

* Metric: request latency
* Condition: >1.5s
* Duration: 1 min
* Notify email

Trigger it with `/slow`.

---

## 🧱 STEP 11: Chaos Test (Like a Pro 😈)

```bash
docker compose stop
docker compose start
```

Now observe:

* Metrics drop
* Logs show restart
* Traces break
* Alerts fire

👉 You’re seeing **signal correlation**, not just dashboards.

---

## 🧨 STEP 12: Destroy Everything (Clean Exit)

```bash
docker compose down --rmi all --volumes
```

💥 Gone.

* No Node
* No npm
* No telemetry agents
* No junk on disk

---


