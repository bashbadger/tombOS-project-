# Tomb OS Hardened Docker Architecture
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build || true

FROM nginx:alpine-slim
LABEL maintainer="Tomb OS Security Enclave <sec-admin@tomb-os.org>"
LABEL description="Zero-Trust Hardened Desktop & Operating System Container Environment"

# Harden Container Filesystem
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app /usr/share/nginx/html
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
