# Dockerfile for AI threat hunting service
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ml_hunter.py .
CMD ["python", "ml_hunter.py"]
