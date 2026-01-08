
# 🐙 Observability Mini Project: Node.js + Docker + Grafana Cloud

**Objective:** Build a fully containerized Node.js application instrumented with **OpenTelemetry**, sending traces and metrics to **Grafana Cloud**. This project demonstrates **end-to-end observability** for a simple app.

---

## ⚡ Introduction to Observability

Observability is the ability to **understand the internal state of your system** from external outputs such as **logs, metrics, and traces**. Unlike simple monitoring, which only shows symptoms, observability helps answer **why something is happening**.

In this project, we will:

* Instrument a Node.js app automatically using **OpenTelemetry**.
* Send telemetry (traces & metrics) to **Grafana Cloud OTLP endpoint**.
* Visualize and explore traces using **Grafana Explore and Application Observability**.

---

## 🧰 Stack Used

| Component               | Purpose                                                             |
| ----------------------- | ------------------------------------------------------------------- |
| **Node.js**             | Application runtime                                                 |
| **Express.js**          | HTTP server framework                                               |
| **Pino / pino-http**    | Logging framework                                                   |
| **OpenTelemetry SDK**   | Auto-instrumentation & telemetry collection                         |
| **OTLP HTTP Exporters** | Sends traces & metrics to Grafana Cloud                             |
| **Docker**              | Containerization                                                    |
| **Docker Compose**      | Multi-container orchestration                                       |
| **Grafana Cloud**       | Cloud observability platform, visualizing traces, metrics, and logs |

---

## 🧱 STEP 0: Prerequisites

You only need **two things**:

✅ Docker Desktop installed & running
✅ Grafana Cloud account + API token

Check Docker:

```bash
docker --version
docker compose version
```
If both commands return a version, Docker is ready.

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/1.png" width="400"> </div>

---


## 🧱 STEP 1: Create Grafana Cloud Account

1. Go to [https://grafana.com](https://grafana.com)
2. Sign up for a free account
3. In Grafana Cloud:

   * Hamburger menu → Connections → Add new → OpenTelemetry → Start setup

---

## 🧱 STEP 2: OpenTelemetry Setup (Important)

Follow Grafana’s OTEL setup wizard:

1. **Choose Language:** Other → Node.js SDK
2. **Choose Infrastructure:** Other → Linux
3. **Instrumentation Method:** OpenTelemetry Collector (for flexibility & routing)
4. **Instrumentation Instructions:**

   * Generate **API token**
   * Copy values for:

     * `OTEL_EXPORTER_OTLP_ENDPOINT`
     * `OTEL_EXPORTER_OTLP_HEADERS`
   * These will be used in `.env` file for Docker

---

## 🧱 STEP 3: Project Structure

```text
DockerGrafanaTask/
│
├── app/
│   ├── index.js        # Main Node app
│   ├── otel.js         # OpenTelemetry SDK & auto-instrumentation
│   ├── package.json    # Dependencies & scripts
│   └── Dockerfile      # Node container setup
│
├── docker-compose.yml  # Container orchestration
└── .env                # Environment variables for OTEL
```

---

## 🧱 STEP 4: Node App Code

### [app/package.json]

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

> **Explanation:** Defines the Node app dependencies. The start script ensures **otel.js** loads before the app to automatically instrument all modules.

---

### [app/index.js]

```js
const express = require("express");
const pinoHttp = require("pino-http");

const app = express();
app.use(pinoHttp()); // Logs all HTTP requests automatically

// Root endpoint
app.get("/", (req, res) => {
  res.send("Hello from Docker Observability 👀");
});

// Slow endpoint for tracing demonstration
app.get("/slow", async (req, res) => {
  await new Promise(r => setTimeout(r, 2000));
  res.send("Slow request 🐌");
});

// Start server on port 3000
app.listen(3000, "0.0.0.0", () => {
  console.log("App running on port 3000");
});
```

> **Flow:** Requests to `/` and `/slow` are auto-instrumented. Spans are sent to the OTLP endpoint configured in `otel.js`.

---

### [app/otel.js]

```js
const { NodeSDK } = require("@opentelemetry/sdk-node");
const { getNodeAutoInstrumentations } = require("@opentelemetry/auto-instrumentations-node");
const { OTLPTraceExporter } = require("@opentelemetry/exporter-trace-otlp-http");
const { OTLPMetricExporter } = require("@opentelemetry/exporter-metrics-otlp-http");
const { Resource } = require("@opentelemetry/resources");

// Parse headers from .env
const headers = {};
process.env.OTEL_EXPORTER_OTLP_HEADERS
  ?.split(",")
  .forEach(h => {
    const [k, v] = h.split("=");
    if (k && v) headers[k] = decodeURIComponent(v);
  });

// Initialize OTEL SDK
const sdk = new NodeSDK({
  resource: new Resource({
    "service.name": process.env.OTEL_SERVICE_NAME || "node-docker-observability",
    "deployment.environment": "dev"
  }),
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT, // Sends spans to Grafana OTLP
    headers
  }),
  metricExporter: new OTLPMetricExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT.replace("/traces", "/metrics"), // Metrics endpoint
    headers
  }),
  instrumentations: [getNodeAutoInstrumentations()] // Auto-instrument Node.js modules
});

// Start sending telemetry
sdk.start()
  .then(() => console.log("✅ OTEL SDK initialized"))
  .catch(err => console.error("❌ OTEL SDK failed:", err));
```

> **Telemetry Flow:**
> Node.js app → OTEL auto-instrumentation → OTLP Trace & Metric Exporter → Grafana Cloud

---

## 🧱 STEP 5: Dockerfile

```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY package.json . 
RUN npm install --only=production

COPY . .

EXPOSE 3000

CMD ["npm", "start"] 
```

> Container builds Node app and installs production dependencies. Port 3000 exposed for browser/test requests.

---

## 🧱 STEP 6: Docker Compose

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
      OTEL_RESOURCE_ATTRIBUTES: ${OTEL_RESOURCE_ATTRIBUTES}
```

> **Explanation:** Docker Compose injects `.env` variables into the container. This allows OTEL SDK to send telemetry to Grafana Cloud without hardcoding credentials.

---

## 🧱 STEP 7: Environment Variables

Create `.env` in project root:

```env
# Traces endpoint
OTEL_EXPORTER_OTLP_ENDPOINT=https://otlp-gateway-prod-ap-south-1.grafana.net/otlp/v1/traces

# API token for Grafana Cloud
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Basic MTQ4NzUzNzpnbGNfZXlKdklqb2lNVFl6...

# Service attributes
OTEL_RESOURCE_ATTRIBUTES=service.name=node-docker-observability
```

> **Tip:** Ensure `/v1/traces` is in the endpoint. Metrics are automatically derived from traces endpoint in `otel.js`.

---

## 🧱 STEP 8: Build & Run

```bash
docker compose up -d --build
```

Check logs:

```bash
docker logs -f <app-container-id>
```

Expected output:

```
App running on port 3000
✅ OTEL SDK initialized
```

> Spans are now being sent to Grafana Cloud.

---

## 🧱 STEP 9: Explore Traces in Grafana

1. Open **Grafana Cloud → Explore → Traces**
2. Set `Service Name = node-docker-observability`
3. You should see spans like:

| Trace ID | Service                   | Span Name       |
| -------- | ------------------------- | --------------- |
| abc123   | node-docker-observability | fs.readFileSync |
| def456   | node-docker-observability | http.get        |

> Takes a few seconds for spans to appear.

---

## 🧱 STEP 10: Clean Up

```bash
docker compose down --rmi all --volumes
```

> Stops all containers, deletes images and volumes, cleaning up your project.

---

## ✅ Conclusion

* A simple Node.js app was instrumented with **OpenTelemetry** and visualized in **Grafana Cloud**.
* Auto-instrumentation captures HTTP requests, DB calls, and file system operations.
* All telemetry flows: **Node app → OTEL SDK → OTLP Exporter → Grafana Cloud → Explore/Observability dashboard**.
* You can now extend this project to include **custom spans**, **database queries**, **error monitoring**, and full **business-level observability**.

---

This file now contains **everything we did**, is clean, includes **comments on code**, and shows the full telemetry flow.

---

If you want, I can **also create a diagram showing how traffic flows** from Node.js → OTEL → Grafana, and you can embed it into this Markdown for better understanding.

Do you want me to do that next?





















































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
// This is dependency + startup control.
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
});


app.listen(3000, "0.0.0.0", () => {
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
process.env.OTEL_EXPORTER_OTLP_HEADERS
  ?.split(",")
  .forEach(h => {
    const [k, v] = h.split("=");
    if (k && v) headers[k] = decodeURIComponent(v);
  });

const sdk = new NodeSDK({
  resource: new Resource({
    "service.name": process.env.OTEL_SERVICE_NAME || "node-docker-observability",
    "deployment.environment": "dev"
  }),
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT,
    headers
  }),
  metricExporter: new OTLPMetricExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT.replace("/traces", "/metrics"),
    headers
  }),
  instrumentations: [getNodeAutoInstrumentations()]
});

sdk.start();
```

---

## 🧱 STEP 4: Dockerfile (Node App Container)

### [app/Dockerfile](/observability/DockerGrafanaTask/app/Dockerfile)

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

### [docker-compose.yml](/observability/DockerGrafanaTask/docker-compose.yml)

```yaml
services:
  app:
    build: ./app
    ports:
      - "3000:3000"
    environment:
      OTEL_EXPORTER_OTLP_ENDPOINT: ${OTEL_EXPORTER_OTLP_ENDPOINT}
      OTEL_EXPORTER_OTLP_HEADERS: ${OTEL_EXPORTER_OTLP_HEADERS}
      OTEL_RESOURCE_ATTRIBUTES: ${OTEL_RESOURCE_ATTRIBUTES}

```

---

## 🧱 STEP 6: Environment Variables (Outside Docker)

Create `.env` file (same folder as compose):

```env
OTEL_EXPORTER_OTLP_ENDPOINT=https://<your-grafana-endpoint>/otlp/v1/traces 
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Basic <your-token>
```

📌 `.env` is read automatically by Docker Compose.
ensure to add /v1/traces at the end of OTLP_ENDPOINT
OTEL_RESOURCE_ATTRIBUTES=service.name=node-docker-observability

---

## 🧱 STEP 7: Build & Run (One Command)

```bash
cd DockerGrafanaTask
ls 
ls -a (to view .env file)

```



### Sequence of execution (VERY IMPORTANT)

---

## 🧱 STEP 9: Observe in Grafana Cloud
---

## 🧨 STEP 12: Destroy Everything (Clean Exit)

```bash
docker compose down --rmi all --volumes
```
