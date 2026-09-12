# Build a small production image for the service.
FROM node:20-bookworm-slim

# curl is used by the container health check and smoke-test commands.
RUN apt-get update && apt-get install -y --no-install-recommends curl && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# Install dependencies first so Docker can cache this layer.
COPY app/package.json ./
RUN npm install --omit=dev

# Copy the application source.
COPY app/ ./

# The service reads PORT from the environment and defaults to 3000.
EXPOSE 3000

CMD ["node", "server.js"]
