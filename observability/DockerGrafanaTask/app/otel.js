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
