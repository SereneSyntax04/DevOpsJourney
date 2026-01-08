
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

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/2.png" width="400"> </div>

---

## 🧱 STEP 2: OpenTelemetry Setup (Important)

1. **Choose Language:** OpenTelemetry SDK → Javascript
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/3.png" width="400"> <img src="/observability/assets/grafanaImg/4.png" width="400"> </div>

2. **Choose Infrastructure:** Linux
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/5.png" width="400"> </div>

3. **Instrumentation Method:** Direct → Generate **API token**
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/6.png" width="400"> <img src="/observability/assets/grafanaImg/7.png" width="400"></div>

4. **Instrumentation Instructions:**

   * Copy values for:

     * `OTEL_EXPORTER_OTLP_ENDPOINT`
     * `OTEL_EXPORTER_OTLP_HEADERS`
   * These will be used in `.env` file for Docker

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/8.png" width="400"> <img src="/observability/assets/grafanaImg/9.png" width="400"> </div>

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

### [app/package.json](/observability/DockerGrafanaTask/app/package.json)

```json
{
  "name": "observability-demo",       // Project/app name
  "version": "1.0.0",                 // App version
  "main": "index.js",                 // Entry point for the app
  "scripts": {
    "start": "node -r ./otel.js index.js"  // Start command: preload 'otel.js' to enable OpenTelemetry before running index.js
  },
  "dependencies": {
    "express": "^4.18.2",             // Web server framework for Node.js
    "pino": "^8.17.0",                // Fast logging library
    "pino-http": "^9.0.0",            // Middleware for logging HTTP requests using pino

    "@opentelemetry/api": "^1.7.0",                       // Core OpenTelemetry API for creating spans, metrics, etc.
    "@opentelemetry/sdk-node": "^0.46.0",                 // Node.js SDK for OpenTelemetry; orchestrates tracing & metrics
    "@opentelemetry/auto-instrumentations-node": "^0.46.0", // Automatically instruments common Node.js modules (HTTP, FS, Express, etc.)
    "@opentelemetry/exporter-trace-otlp-http": "^0.46.0",  // Exports traces to OTLP endpoint (Grafana Cloud)
    "@opentelemetry/exporter-metrics-otlp-http": "^0.46.0", // Exports metrics to OTLP endpoint
    "@opentelemetry/resources": "^1.7.0"                  // Allows defining service metadata (service name, environment)
  }
}
```

> **Explanation:** Defines the Node app dependencies. The start script ensures **otel.js** loads before the app to automatically instrument all modules.

---




### [app/index.js](/observability/DockerGrafanaTask/app/index.js)

```js
const express = require("express");       // Web framework to handle HTTP requests
const pinoHttp = require("pino-http");    // Middleware to automatically log HTTP requests

const app = express();
app.use(pinoHttp()); // Wraps all incoming HTTP requests with logging, including metadata like method, URL, status code

// Root endpoint: simple, fast request
app.get("/", (req, res) => {
  // When this route is called, OpenTelemetry auto-instrumentation (from otel.js) will create a span automatically
  // Span will include HTTP metadata, request/response time, and logs from pino
  res.send("Hello from Docker Observability 👀");
});

// Slow endpoint: simulates a delay to test tracing
app.get("/slow", async (req, res) => {
  // This 2-second delay creates a longer span so you can visualize it in Grafana traces
  await new Promise(r => setTimeout(r, 2000));
  res.send("Slow request 🐌");
});

// Start server on port 3000
// OpenTelemetry auto-instrumentation hooks into this server to capture HTTP spans automatically
app.listen(3000, "0.0.0.0", () => {
  console.log("App running on port 3000");
  // Server is listening; traces from requests will now be exported to Grafana OTLP endpoint via otel.js
});
```

> **Flow:** Requests to `/` and `/slow` are auto-instrumented. Spans are sent to the OTLP endpoint configured in `otel.js`.

---




### [app/otel.js](/observability/DockerGrafanaTask/app/otel.js)

```js
const { NodeSDK } = require("@opentelemetry/sdk-node");  // Core OpenTelemetry SDK for Node.js
const { getNodeAutoInstrumentations } = require("@opentelemetry/auto-instrumentations-node"); // Automatically instruments Node.js modules like HTTP, FS, Express
const { OTLPTraceExporter } = require("@opentelemetry/exporter-trace-otlp-http"); // Exports trace data (spans) via HTTP/OTLP to Grafana
const { OTLPMetricExporter } = require("@opentelemetry/exporter-metrics-otlp-http"); // Exports metrics via HTTP/OTLP to Grafana
const { Resource } = require("@opentelemetry/resources"); // Used to define service metadata

// Parse headers from .env file (for authorization/API token)
const headers = {};
process.env.OTEL_EXPORTER_OTLP_HEADERS
  ?.split(",")                 // Split multiple headers if needed
  .forEach(h => {
    const [k, v] = h.split("="); // Separate key/value
    if (k && v) headers[k] = decodeURIComponent(v); // Decode URL-encoded values
  });

// Initialize the OpenTelemetry SDK
const sdk = new NodeSDK({
  // Define resource attributes for all telemetry (used in Grafana to identify service)
  resource: new Resource({
    "service.name": process.env.OTEL_SERVICE_NAME || "node-docker-observability", // Name of your service
    "deployment.environment": "dev" // Environment tag
  }),
  
  // Trace exporter: sends spans to Grafana Cloud
  traceExporter: new OTLPTraceExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT, // OTLP endpoint from Grafana Cloud
    headers // Authorization headers from API token
  }),
  
  // Metric exporter: sends metrics to Grafana Cloud
  metricExporter: new OTLPMetricExporter({
    url: process.env.OTEL_EXPORTER_OTLP_ENDPOINT.replace("/traces", "/metrics"), // Metrics endpoint (replace /traces with /metrics)
    headers
  }),
  
  // Auto-instrumentation of Node.js libraries (HTTP, FS, Express, etc.)
  instrumentations: [getNodeAutoInstrumentations()]
});

// Start the SDK to capture telemetry and send it to Grafana
sdk.start()
  .then(() => console.log("✅ OTEL SDK initialized"))  // Logs success
  .catch(err => console.error("❌ OTEL SDK failed:", err)); // Logs error if something fails
```

> **Telemetry Flow:**
> Node.js app → OTEL auto-instrumentation → OTLP Trace & Metric Exporter → Grafana Cloud

---




## 🧱 STEP 5: Dockerfile

### [app/Dockerfile](/observability/DockerGrafanaTask/app/Dockerfile)

```dockerfile
# Use official Node.js 18 Alpine image (lightweight, minimal OS)
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy only package.json first (optimization for caching dependencies)
COPY package.json . 

# Install only production dependencies (no devDependencies)
RUN npm install --only=production

# Copy all remaining files (index.js, otel.js, other code) into container
COPY . .

# Expose port 3000 to the host (so we can access Express app)
EXPOSE 3000

# Start the Node.js app, preloading OpenTelemetry via otel.js
CMD ["npm", "start"] 
# npm start runs: node -r ./otel.js index.js
# -r ./otel.js ensures OpenTelemetry SDK starts before app
# telemetry (traces + metrics) automatically flows to Grafana Cloud
```

> Container builds Node app and installs production dependencies. Port 3000 exposed for browser/test requests.

---





## 🧱 STEP 6: Docker Compose

### [docker-compose.yml](/observability/DockerGrafanaTask/docker-compose.yml)

```yaml

services:
  app:
    # This service is your Node.js application
    build: ./app
    # Build the Docker image using the Dockerfile inside ./app

    ports:
      - "3000:3000"
      # Expose container port 3000 to host port 3000
      # Access app at http://localhost:3000

    environment:
      # OTLP endpoint where OpenTelemetry sends traces
      # This points DIRECTLY to Grafana Cloud Tempo
      OTEL_EXPORTER_OTLP_ENDPOINT: ${OTEL_EXPORTER_OTLP_ENDPOINT}

      # Authorization header (Grafana Cloud API token in Basic auth)
      # Used by OTLP exporter to authenticate with Grafana Cloud
      OTEL_EXPORTER_OTLP_HEADERS: ${OTEL_EXPORTER_OTLP_HEADERS}

      # Resource attributes attached to every trace/span
      # This is how Grafana knows your service name
      OTEL_RESOURCE_ATTRIBUTES: ${OTEL_RESOURCE_ATTRIBUTES}

```

> **Explanation:** Docker Compose injects `.env` variables into the container. This allows OTEL SDK to send telemetry to Grafana Cloud without hardcoding credentials.

---




## 🧱 STEP 7: Environment Variables

Create `.env` in project root:

```env
# OTLP HTTP endpoint for sending TRACE data
# This is Grafana Cloud Tempo's ingestion endpoint
# IMPORTANT: /v1/traces is REQUIRED, otherwise you get 404
# Traces endpoint
OTEL_EXPORTER_OTLP_ENDPOINT=https://otlp-gateway-prod-ap-south-1.grafana.net/otlp/v1/traces

# Authorization header used by OTLP exporter
# This is NOT the raw API token
# It is a Base64-encoded "instanceID:API_TOKEN" value
# API token for Grafana Cloud
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Basic MTQ4NzUzNzpnbGNfZXlKdklqb2lNVFl6...

# Resource attributes attached to every span and trace
# Grafana uses this to group traces by service
# Service attributes
OTEL_RESOURCE_ATTRIBUTES=service.name=node-docker-observability
```

> **Tip:** Ensure `/v1/traces` is in the endpoint. Metrics are automatically derived from traces endpoint in `otel.js`.

---




## 🧱 STEP 8: Build & Run

```bash
docker compose up -d --build
```
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/10.png" width="400"> <img src="/observability/assets/grafanaImg/11.png" width="400"> <img src="/observability/assets/grafanaImg/12.png" width="400"></div>

Check logs:

```bash
docker logs -f <app-container-id>
```
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/13.png" width="400"> </div>

> Spans are now being sent to Grafana Cloud.

---




## 🧱 STEP 9: Verify Telemetry from Inside the Container

This step confirms **three critical things**:

1. Environment variables are loaded correctly
2. Application is reachable inside the container
3. Traces are actually being generated and sent


###  Enter the Running Container

First, get the container ID:

```bash
docker ps
```

Then exec into it:

```bash
docker exec -it <container-id> sh
```

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/14.png" width="400"> </div>

You are now **inside the Node.js container**.



###  Verify OpenTelemetry Environment Variables

Run:

```bash
env | grep OTEL
```

Expected output (example):

```text
OTEL_EXPORTER_OTLP_ENDPOINT=https://otlp-gateway-prod-ap-south-1.grafana.net/otlp/v1/traces
OTEL_EXPORTER_OTLP_HEADERS=Authorization=Basic <base64-token>
OTEL_RESOURCE_ATTRIBUTES=service.name=node-docker-observability
```

✅ Confirms Docker Compose injected `.env` correctly
❌ Missing values = traces will NOT reach Grafana

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/15.png" width="400"> </div>

---

###  Install `curl` Inside Container (Alpine Linux)

The Node image is Alpine-based and does not include `curl` by default.

Install it temporarily:

```bash
apk add --no-cache curl
```
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/16.png" width="400"> </div>

(This does not persist after container restart — expected behavior)

---

###  Generate Traffic from Inside the Container

Trigger HTTP requests **from within the container**:

```bash
curl http://localhost:3000/
curl http://localhost:3000/
curl http://localhost:3000/
```

Each request:

* Creates a new HTTP span
* Attaches trace & span IDs
* Sends telemetry via OTLP to Grafana Cloud

You can also test the slow endpoint:

```bash
curl http://localhost:3000/slow
```

This generates **longer spans**, useful for latency analysis.

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/17.png" width="400"> </div>


### 🌐 View the Application in Browser

You can also access the application directly from your browser.

**Root endpoint**

[http://localhost:3000](http://localhost:3000)

Returns a simple response and generates fast HTTP traces.

**Slow endpoint (Tracing Demo)**

[http://localhost:3000/slow](http://localhost:3000/slow)


Introduces an artificial delay (~2 seconds) to demonstrate
long-running spans and latency in Grafana traces.
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/18.png" width="400"> <img src="/observability/assets/grafanaImg/18b.png" width="400"> </div>

---

###  Confirm in Container Logs

Exit the container and check logs:

```bash
docker logs <container-id>
```

<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/19.png" width="400"> </div>

This confirms:

* OpenTelemetry is active
* Traces are being generated per request

---

###  Confirm in Grafana Cloud

1. Open **Grafana Cloud**
2. Go to **Explore**
3. Select:

   ```
   grafanacloud-<instance>-traces
   ```
4. Time range: **Last 15 minutes**
5. Leave query as:

   ```traceql
   {}
   ```

You should now see trace rows appear.
<div style="display:flex; gap:10px;"> <img src="/observability/assets/grafanaImg/20.png" width="400"> <img src="/observability/assets/grafanaImg/21.png" width="400"> </div>


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

