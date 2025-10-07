# Next.js DevOps Internship Assessment

A containerized Next.js application deployed using Docker, GitHub Actions, and Kubernetes (Minikube).

## Project Overview

This project demonstrates a complete DevOps pipeline for a Next.js application:
- **Containerization** with multi-stage Docker build
- **CI/CD** using GitHub Actions and GitHub Container Registry
- **Orchestration** with Kubernetes manifests
- **Local development** with Minikube

## Project Structure

nextjs-devops-assessment/
├── .github/workflows/
│ └── docker-build-push.yml # GitHub Actions CI/CD workflow
├── k8s/
│ ├── deployment.yaml # Kubernetes Deployment
│ └── service.yaml # Kubernetes Service
├── src/ # Next.js application source
├── Dockerfile # Multi-stage Dockerfile
├── next.config.ts # Next.js configuration
└── package.json # Node.js dependencies

## Prerequisites

- Docker
- Kubernetes (Minikube)
- kubectl
- Node.js 18+

## Local Development

### Run the application locally

```bash
# Install dependencies
npm install

# Start development server
npm run dev
```
The application will be available at http://localhost:3000

## Build and run with Docker locally
```bash
# Build the Docker image
docker build -t nextjs-app:latest .

# Run the container
docker run -d -p 3000:3000 --name nextjs-container nextjs-app:latest
```
Access the application at http://localhost:3000

## CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Builds Docker image on push to main branch
2. Pushes image to GitHub Container Registry (GHCR)
3. Uses proper image tagging with metadata

## Manual Image Push (if needed)

```bash
# Log in to GHCR
echo $GHCR_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# Build and tag image
docker build -t ghcr.io/username/nextjs-devops-assessment:latest .

# Push image
docker push ghcr.io/username/nextjs-devops-assessment:latest
```

## Kubernetes Deployment with Minikube

### Start Minikube

```bash
# Start Minikube cluster
minikube start

# Enable Minikube ingress (optional)
minikube addons enable ingress
```

### Deploy to Minikube
```bash
# Apply Kubernetes manifests
kubectl apply -f k8s/

# Check deployment status
kubectl get deployments
kubectl get pods
kubectl get services
```

### Access the Application
```bash
# Get the Minikube service URL
minikube service nextjs-service --url

# Or use port-forwarding
kubectl port-forward service/nextjs-service 8080:80
```
Access the application via the provided URL or at http://localhost:8080

### Management Commands
```bash
# View logs
kubectl logs -f deployment/nextjs-app

# Scale deployment
kubectl scale deployment nextjs-app --replicas=3

# Delete deployment
kubectl delete -f k8s/
```

## Health Checks
The application includes:
- **Readiness Probe**: Checks if container is ready to receive traffic
- **Liveness Probe**: Checks if container is running properly

## Resource Management
Kubernetes deployment includes resource requests and limits:
- Requests: 100m CPU, 128Mi Memory
- Limits: 200m CPU, 256Mi Memory

## Best Practices Implemented

### Docker
- Multi-stage builds for smaller image size
- Non-root user for security
- Proper layer caching
- Minimal Alpine base image

### Kubernetes
- Health checks (readiness and liveness probes)
- Resource limits
- Multiple replicas for high availability
- Proper service exposure

### Security
- Non-root user in container
- Minimal base image
- Environment-specific configurations

## Troubleshooting

### Common Issues
1. **Minikube not starting**: Ensure virtualization is enabled in BIOS
2. **Image pull errors**: Check image tags and registry permissions
3. **Port conflicts**: Change exposed ports in service.yaml

## Debugging Commands
```bash
# Check cluster status
minikube status

# View all resources
kubectl get all

# Describe specific resource
kubectl describe deployment nextjs-app

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp
```

## Cleanup
```bash
# Delete Kubernetes resources
kubectl delete -f k8s/

# Stop Minikube
minikube stop

# Delete Minikube cluster
minikube delete
```
# Triggering CI/CD
