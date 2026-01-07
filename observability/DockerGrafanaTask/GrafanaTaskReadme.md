
# 🐳 Observability Mini Project 

## 🧱 STEP 0: Prerequisites

You only need **two things** for this project:

✅ **Docker Desktop** (installed & running)  
✅ **Grafana Cloud account + API token**


###  Install Docker Desktop

Download and install **Docker Desktop** for your OS.

Verify installation:

```bash
docker --version
docker compose version
```

If both commands return a version, Docker is ready.

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/1.png" width="400"> </div>

---

## 🧱 STEP 1: Create Grafana Cloud Account (Free)

1. Go to **[https://grafana.com](https://grafana.com)**
2. Create a **free Grafana Cloud account** using email
3. After login, from the home page:

   * Click the **hamburger menu (☰)**
   * Go to **Connections**
   * Click **Add new connection**
   * Scroll and select **OpenTelemetry**
   * Click **Start setup**

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/2.png" width="400"> </div>

<br>

### 3️⃣ OpenTelemetry Setup (Important)

Follow the setup wizard exactly:

**a. Choose language**

* Select **OpenTelemetry SDK**
* Choose **Other**
* Click **Next**

**b. Choose infrastructure**

* Select **Other**
* Click **Next**

**c. Choose method**

* Select **OpenTelemetry Collector**
* Click **Next**

**d. Instrumentation instructions (IMPORTANT)**

* Generate an **API Token**
* Copy the values shown under **Append the generated configuration**
* You will get:

  * `OTEL_EXPORTER_OTLP_ENDPOINT`
  * `OTEL_EXPORTER_OTLP_HEADERS` (contains the API token)

These values will be used later in the Docker `.env` file.

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/3.png" width="400"> <img src="/observability/assets/grafanaImg/4.png" width="400"></div>

---

## 🧱 STEP 2: Project Structure 

Create a folder anywhere:

```bash
mkdir DockerGrafanaTask
cd DockerGrafanaTask
```

Structure will be:

```
DockerGrafanaTask/
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

### [app/package.json](/observability/DockerGrafanaTask/app/package.json)

```json
{
  // This is dependency + startup control.
  "name": "observability-demo",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node -r ./otel.js index.js" 
    // Most important line [-r ./otel.js] = require otel BEFORE app starts
    // Without this → no traces
  },
  "dependencies": {
    "express": "^4.18.2", //web server
    "pino": "^8.17.0", //structured logs
    "pino-http": "^9.0.0", //metrics + traces auto capture

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

### [app/index.js](/observability/DockerGrafanaTask/app/index.js)

```js
// This is your actual application.
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
}); //artificial 2s delay (for trace visibility)

app.listen(3000, () => {
  console.log("App running on port 3000");
});
```

---

### [app/otel.js](/observability/DockerGrafanaTask/app/otel.js)

```js
//This is the observability brain.
const { NodeSDK } = require("@opentelemetry/sdk-node");
const { getNodeAutoInstrumentations } = require("@opentelemetry/auto-instrumentations-node");
const { OTLPTraceExporter } = require("@opentelemetry/exporter-trace-otlp-http");
const { OTLPMetricExporter } = require("@opentelemetry/exporter-metrics-otlp-http");
const { Resource } = require("@opentelemetry/resources");

const headers = {};
process.env.OTEL_EXPORTER_OTLP_HEADERS //Read auth headers from env
  ?.split(",")
  .forEach(h => {
    const [k, v] = h.split("=");
    headers[k] = v;
  });

const sdk = new NodeSDK({
  resource: new Resource({
    "service.name": "node-docker-observability" // Identify the service
  }),
  //Export telemetry

  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT,
    headers
  }), //traceExporter → traces

  metricExporter: new OTLPMetricExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT, //Destination:That is Grafana Cloud OTLP gateway.
    headers
  }), //metricExporter → metrics

  // Auto-instrumentation
  instrumentations: [getNodeAutoInstrumentations()]
  // This automatically instruments: Express, HTTP, DNS, Net, Timers
  // No manual tracing code needed.
});

sdk.start();
```

---

## 🧱 STEP 4: Dockerfile (Node App Container)

### [app/Dockerfile](/observability/DockerGrafanaTask/app/Dockerfile)

```dockerfile
# This defines how the container is built.

FROM node:18-alpine 
# “Start my container from an existing Node.js image. (alpine → lightweight Linux distro)

WORKDIR /app
# Creates /app directory inside the container, All future commands run from /app

COPY package.json . 
# Copies only package.json , from your laptop → into container /app
RUN npm install --only=production
# Installs dependencies listed in package.json , Skips devDependencies (OpenTelemetry libraries are production deps So they ARE installed)

COPY . .
#Copies everything in app/

EXPOSE 3000
# This container listens on port 3000

CMD ["npm", "start"]

```

👉 Lightweight, clean, disposable.

---

## 🧱 STEP 5: Docker Compose (THIS IS THE CORE)

### [docker-compose.yml](/observability/DockerGrafanaTask/docker-compose.yml)

```yaml
version: "3.9"

services:
  app:
    build: ./app
    ports:
      - "3000:3000"
    environment:
      OTEL_EXPORTER_OTLP_ENDPOINT: ${OTEL_EXPORTER_OTLP_ENDPOINT}
      OTEL_EXPORTER_OTLP_HEADERS: ${OTEL_EXPORTER_OTLP_HEADERS}
```

---

## 🧱 STEP 6: Environment Variables (Outside Docker)

Create `.env` file (same folder as compose):

```env
OTEL_EXPORTER_OTLP_ENDPOINT=https://<your-grafana-endpoint>/otlp
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Basic%2<your-token>
```

📌 `.env` is read automatically by Docker Compose.

---

## 🧱 STEP 7: Build & Run (One Command)

```bash
cd DockerGrafanaTask
ls 
ls -a (to view .env file)
docker compose up --build
```

You’ll see:

```
App running on port 3000
```

### Sequence of execution (VERY IMPORTANT)

1. Container starts

2. Docker runs npm start

3. Node loads otel.js FIRST (-r)

4. OpenTelemetry hooks into:

  - HTTP

  - Express

  - Event loop

5. Then index.js starts

6. Express app listens on port 3000

This ordering is CRITICAL
If otel.js loads AFTER Express → no auto instrumentation
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


