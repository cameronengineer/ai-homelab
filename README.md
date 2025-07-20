# AI Homelab Shenanigans

Welcome to your personal AI playground! This project is designed for tinkering, experimenting, and generally messing around with Large Language Models (LLMs) in a self-hosted homelab environment. Think of it as your digital sandbox for AI exploration.

## What's Inside?

This setup primarily focuses on getting **Ollama** up and running smoothly, allowing you to easily manage and deploy various LLM models.

*   **Ollama Deployment**: Ollama has been deployed to your Kubernetes cluster via Helm, ensuring a stable and manageable setup.
*   **Automated Model Synchronization**: The system automatically handles the synchronization of desired LLM models, including resilient downloads that restart stalled processes every 30 seconds to ensure completion.
*   **Open WebUI**: An optional component for a user-friendly web interface to interact with your deployed LLMs.

## Getting Started

This project is designed to be deployed using Helm. Ensure you have Helm and kubectl configured for your Kubernetes cluster.

### Prerequisites

*   **Kubernetes Cluster**: A running Kubernetes cluster.
*   **Helm**: Installed and configured.

### Deployment

1.  **Clone the Repository**:
    ```bash
    git clone <your-repo-url>
    cd ai-homelab
    ```

2.  **Configure Models**:
    Edit the `values.yaml` file to specify which Ollama models you want to have available. The `OLLAMA_MODELS` environment variable will be populated from this list.

    Example `values.yaml` snippet:
    ```yaml
    ollama:
      enabled: true
      models:
        - "llama2:7b"
        - "mistral:7b"
        # Add more models here as needed
    ```

3.  **Deploy with Helm**:
    Upgrade or install the Helm chart:
    ```bash
    helm upgrade --install ai-stack . --namespace default --reuse-values
    ```

## Contributing

If you have ideas for new features, improvements, or want to add support for other AI tools, feel free to open an issue or a pull request. Just remember, keep it fun and experimental!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.