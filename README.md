# AI Homelab Helm Chart

Deploy your personal AI playground to Kubernetes! This Helm chart bundles popular open-source AI tools for easy homelab deployment.

## Features

- **Ollama**: Run and manage large language models (LLMs) locally
- **Open WebUI**: User-friendly web interface for interacting with LLMs
- **LiteLLM**: Unified API gateway for multiple LLM providers (experimental)
- **PostgreSQL**: Optional database backend for LiteLLM
- **Automated Model Management**: Pre-load Ollama models during deployment
- **Persistent Storage**: PVCs for model data and application state

## Components

### Ollama
- Runs LLMs locally on your Kubernetes cluster
- Automatically downloads specified models during deployment
- Persistent storage for downloaded models
- Health checks ensure service availability

### Open WebUI
- Modern web interface for interacting with Ollama
- Connects directly to Ollama service
- Optional persistent storage for user data
- Configurable resource limits

### LiteLLM (Experimental)
- Unified API gateway for multiple LLM providers
- Master key authentication
- Optional PostgreSQL backend for persistence
- Metrics endpoint for monitoring

## Prerequisites

- Kubernetes cluster (v1.19+)
- Helm (v3+)
- kubectl configured for your cluster
- StorageClass configured for persistent volumes (if using persistence)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/your-repo/ai-homelab.git
cd ai-homelab
```

2. Configure your deployment in `values.yaml`:
```yaml
# Enable components
ollama:
  enabled: true
  models:
    - "llama3:8b"
    - "mistral:7b"

openWebUI:
  enabled: true

litellm:
  enabled: false  # Experimental
```

3. Deploy the chart:
```bash
helm upgrade --install ai-stack . --namespace ai --create-namespace
```

## Configuration

### values.yaml Overview
```yaml
# Global settings
globalConfig:
  imagePullPolicy: IfNotPresent

# Ollama configuration
ollama:
  enabled: true
  replicaCount: 1
  image:
    repository: ollama/ollama
    tag: latest
  persistence:
    enabled: true
    size: 10Gi
  models:
    - "llama3:8b"

# Open WebUI configuration
openWebUI:
  enabled: true
  image:
    repository: ghcr.io/open-webui/open-webui
    tag: main
  persistence:
    enabled: true
    size: 5Gi

# LiteLLM configuration (experimental)
litellm:
  enabled: false
  masterKey: "your-secret-key-here"

# PostgreSQL configuration (required for LiteLLM)
postgresql:
  enabled: false
  auth:
    postgresPassword: "dbpassword"
```

## Accessing Services

| Service    | Port  | Access Method                 |
|------------|-------|-------------------------------|
| Ollama     | 11434 | `http://<service-name>:11434` |
| Open WebUI | 8080  | `http://<service-name>:8080`  |
| LiteLLM    | 4000  | `http://<service-name>:4000`  |

## Persistence

All components support persistent storage via PersistentVolumeClaims:
- Ollama: Stores downloaded models (10Gi by default)
- Open WebUI: Stores user data and settings (5Gi by default)
- PostgreSQL: Stores LiteLLM data (8Gi by default)

Disable persistence by setting `component.persistence.enabled: false`

## Health Monitoring

Each component includes configurable health checks:
- Liveness probes restart unhealthy containers
- Readiness probes manage traffic routing
- Customize timing in `values.yaml`

## Uninstallation

```bash
helm uninstall ai-stack --namespace ai
kubectl delete pvc -l app.kubernetes.io/instance=ai-stack -n ai
```

## Contributing

Contributions welcome! Please follow these guidelines:
1. Open an issue to discuss proposed changes
2. Fork the repository and create a feature branch
3. Submit a pull request with clear documentation

## License

MIT License - see [LICENSE](LICENSE) for details.