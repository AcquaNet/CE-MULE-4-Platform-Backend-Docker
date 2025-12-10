docker build -t 92455890/sota-status-viewer-backend-server:1.0.0 .
docker run --rm -e API_STATUS_URL="https://localhost:8082/api/v1/status" 92455890/sota-status-viewer-backend-server:1.0.0