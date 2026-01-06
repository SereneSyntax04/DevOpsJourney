# Observability & Monitoring 

---

## What is Observability?

Observability is the ability to **understand what’s happening inside a system** by looking at the signals it produces.

👉 It helps answer **WHY** something broke.

**Mental model:**

* Signal = metrics / logs / traces / events
* Observability = ability to explain *cause*, not just *symptoms*

---

## What is Monitoring?

Monitoring is about **watching system health** using dashboards and alerts.

👉 It helps answer **WHAT** is broken.

**Mental model:**

* Monitoring is built *on top of* observability data
* It reacts to known problems (thresholds, alerts)

---

### Short Difference

* **Monitoring** → tells you *something is wrong*
* **Observability** → tells you *why it is wrong*

They work best **together**, not separately.

---

## Why Observability is Important

Systems will fail. That’s reality.

Observability helps teams:

* Detect failures faster
* Understand root causes
* Recover quickly
* Improve reliability
* Make data-driven decisions

**Key idea:**

> Reliability does NOT come from perfect code.
> It comes from understanding failures fast.

Bottom line:
**Reliable systems are not perfect systems — they are observable systems.**

---

## Pillars of Observability (Signals)

> These are the **signals** in the mental model.

### 1. Metrics

Numeric values showing system performance.

Examples:

* CPU usage
* Memory usage
* Request count
* Response time

Used for:

* Dashboards
* Alerts
* Trend analysis

**Think:** numbers over time.

---

### 2. Logs

Text records describing events in detail.

Examples:

* Error messages
* Request/response logs
* Debug logs

Used for:

* Debugging
* Understanding exact failures

**Think:** detailed context.

---

### 3. Traces

Show the **journey of a single request** across services.

Example:

* User request → API → DB → Cache → API → User

Used for:

* Finding slow services
* Debugging microservices

**Think:** request path + timing.

---

### 4. Events

Signals for important occurrences.

Examples:

* Service restart
* Deployment
* Crash

Used for:

* Correlating failures
* Understanding system changes

**Think:** something important happened.

---

## Observability Architecture (Simple Flow)

> This section explains **Source → Collector → Backend → Visualization**.

1. **Instrumentation (Source)**

   * Code or infrastructure emits metrics, logs, traces, events

2. **Collection (Collector)**

   * Agents or collectors gather the data
   * Example: Prometheus, OpenTelemetry Collector

3. **Processing**

   * Data is batched, filtered, or transformed

4. **Export (Backend)**

   * Data is sent to an observability backend
   * Example: Grafana Cloud

5. **Visualization**

   * Dashboards, queries, alerts

---

## Types of Observability Architectures

### Vendor-Based Observability

* Uses paid tools (example: Grafana Cloud)
* Quick to set up
* Less maintenance
* Can be expensive
* Risk of vendor lock-in

**Mental note:** fast start, less control.

---

### Open-Source Observability

* Uses free tools
* More control
* Lower cost
* More maintenance and scaling effort

**Mental note:** more control, more responsibility.

---

## OpenTelemetry (OTel)

### What is OpenTelemetry?

An **open-source standard** for observability.

It provides:

* Standard instrumentation libraries (Source)
* A single collector (Collector)
* Vendor-agnostic setup (easy backend change)

**Important:**

> OpenTelemetry does NOT replace Grafana.
> It standardizes how data is collected and sent.

---

### OpenTelemetry Collector Components

> This is the **Collector** in the mental model.

* **Receiver** → receives data (metrics, logs, traces)
* **Processor** → modifies/batches data
* **Exporter** → sends data to backend
* **Extensions (optional)** → auth, health checks, etc.

**One-line memory trick:**

> Receive → Process → Export

---

### Pros of OpenTelemetry

* No vendor lock-in
* Standardized observability
* Easy vendor switching
* Supports multiple backends

---

### Cons of OpenTelemetry

* Open-source maintenance challenges
* Limited support for some languages
* Some features still evolving

---

## Tools Used in Course

> Mapping tools to the mental model:

* **Node.js Application** → Source
* **OpenTelemetry Libraries** → Instrumentation
* **OpenTelemetry Collector** → Collector
* **Grafana Cloud** → Backend + Visualization

---
<br>






# Metrics & Monitoring (Deep Dive)

> Metrics are the **most common signal** you’ll work with.

## What are Metrics?

Metrics are **numbers** that tell you how your system is behaving.

Think of them as the **vitals of your system**:

* CPU %
* Memory usage
* Number of requests
* Response time

They can be:

* **Default** (come with software)
* **Custom** (you define them for business needs)

---

## Metric Types (Very Important)

### 1️⃣ Counters

👉 **Only go up**

Used for **counting events**

Examples:

* Number of API requests
* Number of errors
* Number of logins
* Product views

When to use:

* When the value should **never decrease**
* When you want to calculate **rates** (requests/sec)

**Mental trick:** counters = counting things.

---

### 2️⃣ Gauges

👉 **Go up and down**

Used for **current state**

Examples:

* CPU usage
* Memory usage
* Active users
* Open connections

When to use:

* When you want a **snapshot** at a point in time
* When the value can increase **or** decrease

**Mental trick:** gauges = speedometer.

---

### 3️⃣ Histograms

👉 **Measure duration & distribution**

Used for **latency and performance**

Examples:

* Request duration
* Response time
* Processing time

When to use:

* When exact values don’t matter
* When you want **averages or percentiles (P95, P99)**

**Mental trick:** histograms = how long things take.

---

## Why These Metrics Matter

| Goal               | Metric Type |
| ------------------ | ----------- |
| Performance tuning | Gauges      |
| Capacity planning  | Counters    |
| User experience    | Histograms  |

---

## Analyzing Metrics (Easy Math)

### Sum

Total count over time
👉 *Total requests in 1 hour*

---

### Rate

How fast something changes
👉 *Requests per second*

---

### Average (Mean)

Typical value
👉 *Average response time*

⚠️ Problem: hides slow users

---

### Percentiles (Very Important)

Shows **real user experience**

Common ones:

* **P50** → normal user
* **P90 / P95** → slow users
* **P99** → worst experience

Why percentiles > average:

* Average lies
* Percentiles expose outliers

Example:

* P99 = 2s → 99% users got response ≤ 2s

---

## Choosing the Right Metrics

### Google’s Four Golden Signals

Must-know for exams & interviews 👇

1. **Errors** – failed requests
2. **Latency** – response time
3. **Throughput** – request volume
4. **Saturation** – resource usage (CPU, memory)

**Mental model:**

> If these 4 look healthy, your system is probably healthy.

---

## Types of Metrics by Purpose

### Actionable Metrics

* Trigger alerts
* Need immediate action

Example: Service down, high error rate

---

### Exploratory Metrics

* Used for investigation
* Help find root cause

Example: CPU usage during outage

---

### Reporting Metrics

* Business or product focused
* Dashboards only

Example: Number of signups, product views

---

## Good Metrics Characteristics

Good metrics are:

* ✅ Understandable
* ✅ Actionable
* ✅ Improvable
* ✅ Purpose-driven
* ✅ Multidimensional (tags)

### Tags Example

* environment = prod / staging
* region = India / US
* service = checkout / auth

Tags help you **slice and isolate problems**.

---

## Metrics in Real Life (Grafana + Prometheus)

> This section ties everything together.

Simple flow:

1. App emits metrics (Source)
2. Prometheus scrapes `/metrics` (Collector)
3. OpenTelemetry Collector processes & forwards (Collector)
4. Metrics sent to Grafana Cloud (Backend)
5. You visualize & query (Visualization)

Custom metrics example:

* `product_views_total`
* `category_views_total`

You can:

* Sum metrics
* Group by labels
* Calculate rates
* Find P95 / P99 latency

---
<br>




# Tracing & Distributed Systems 

## What is Tracing?
- Shows **request flow** through services and infrastructure.
- Each trace = user interaction; made of **spans** (individual hops).
- Span length → latency; errors → failures.
- Helps answer **why something broke** (metrics tell what broke).
- **Sampling** reduces trace volume to save costs.

## Using Tracing (Tempo + Grafana Cloud)
- Instrument app (OpenTelemetry or vendor-specific agents).
- **Traces**: Parent trace + child spans → visualized as waterfall.
- Custom spans & attributes can be added.
- Export traces via OTLP → Grafana Cloud / Tempo.
- Analyze:
  - Filter by service, span, duration, tags.
  - Check latency and errors.
  - Use **Service Graph** for visual trace flow.
- Generate **metrics from traces** → dashboards, alerts, percentiles.

> Traces + metrics = deep insight into app performance & user experience.


---
<br>






# Logging & Log Management 

## What is Logging?
- Logs = text lines emitted by services or infrastructure showing events.
- Can be **default logs** (e.g., proxy access logs) or **custom application logs**.
- **Structured logs** (JSON) are easier to read, analyze, and process.
- Helps track application behavior, troubleshoot issues, and improve observability.

## Best Practices
- **Structure your logs**: Use JSON with relevant fields (timestamps, IDs, etc.).
- **Log levels**: Error, Warning, Info, Debug, Fatal → helps in alerting & analysis.
- **Clear messages**: Concise and descriptive for easier troubleshooting.
- **Data compliance**: Avoid logging sensitive info like PII unless necessary.
- **Retention & lifecycle**: Balance between active querying and archiving to manage costs.
- Logs can be used for **troubleshooting, analytics, and auditing**.

## Log Collection & Usage
- Use **logging frameworks** provided by your programming language.
- Logs can be **filtered, grouped, or analyzed** by fields or tags.
- Can **generate metrics** from logs (e.g., count of errors, latency calculations).
- Supports **alerts** based on log content or frequency.

## Logging in Action (Loki + Grafana Cloud)
- **Node.js example**: Using Winston to write structured JSON logs.
- Logs include **trace ID** to link logs with traces.
- Export logs via **OTLP collector** → Grafana Cloud.
- In Grafana:
  - Filter logs by labels, log levels, or custom attributes.
  - Link logs to traces for easy debugging.
  - Alert on logs like metrics (e.g., error count).

> Proper logging gives actionable insights, connects with traces and metrics, and boosts observability.

---
<br>







# Collecting and Analyzing System Events

## What are Events?
- Events = **changes in or outside your system** that can affect uptime or availability.
- Examples: deployments, infrastructure restarts, configuration changes.
- Events provide insight **even when the system seems fine**.
- Correlating events with logs, metrics, and traces helps **understand root causes**.

## Event Collection
- Methods depend on **event type** and **observability tools**.
- Can be collected via:
  - **Integrations** with tools (e.g., Jenkins CI/CD plugin in Grafana).
  - **Metrics-based detection** (e.g., container start/stop metrics via Prometheus).

## Event Analysis & Correlation
- Correlate events with other signals:
  - Deployment metrics → link deployments to service behavior.
  - Container metrics → track infrastructure changes.
- Helps identify causes of **outages, performance changes, or anomalies**.
- Observability platforms (Grafana, Prometheus) support integration and custom metric/event correlation.

> Events complement logs, metrics, and traces by giving **context on changes** impacting system behavior.

---
<br>





# Application & Infrastructure Monitoring 

## 1. Application Performance Monitoring (APM)
- Uses **metrics, logs, and traces** together to understand application behavior.
- Measures performance of **API endpoints** to gauge system health.
- **Apdex score** (0–1) indicates overall service health.
- Benefits:
  - Drill down from overall health → individual endpoints/functions.
  - Improved user experience & faster incident triage.
  - Eliminates context switching between signals/tools.
- Implementation:
  - Instrument services according to language/tooling.
  - Grafana Cloud example: service overview, traces, logs, service map, dependencies.
- Popular APM tools: Datadog, New Relic, Honeycomb, Elastic APM.

## 2. Synthetic Monitoring
- **Black box monitoring**: test endpoints with expected input/output.
- Checks: HTTP status, payload content, completion time.
- Run from multiple locations to measure **latency and uptime**.
- Alerts on failures.
- Grafana Cloud example: define checks, frequency, HTTP method, locations, and view results in dashboard.

## 3. Infrastructure Monitoring
- Monitors **underlying resources**: CPU, memory, disk, database metrics.
- Ensures infrastructure has sufficient resources to run efficiently.
- Methods:
  - Collect metrics directly from infrastructure.
  - Enable **integrations** via observability tools.
- Grafana example: Docker metrics collection, dashboards, ready-to-use integrations.

## 4. Product Monitoring
- Focuses on **custom metrics, logs, and traces** relevant to your product.
- Example:
  - E-commerce: daily sales.
  - FinTech: partner reliability for transactions.
- Use relevant **tags & attributes** to analyze product-specific data.

## 5. Other Monitoring Techniques
- **Profiling**: Collect CPU, memory, response time data to find bottlenecks.
- **Real User Monitoring (RUM)**: Frontend monitoring of user actions, locations, devices.
- **Network Monitoring**: Observe bandwidth, latency, packet loss; detect outages and optimize networks.
- **Security Monitoring**: Detect threats, unauthorized access, data breaches; integrate logs and network activity.
- Others: database performance monitoring, cloud monitoring, compliance monitoring, etc.
- Principle: Instrument system → collect signals → process with tools → analyze/alert.

> Observability signals (metrics, logs, traces) are the foundation for all these monitoring techniques. Proper instrumentation and tooling selection are key for actionable insights.
