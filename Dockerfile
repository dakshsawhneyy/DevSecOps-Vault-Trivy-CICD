# Stage 1: Build
FROM node:18 AS builder

WORKDIR /app

COPY package*.json .
RUN npm install

COPY app.js app.js

# Stage 2: Production
FROM node:18-slim
WORKDIR /app

COPY --from=builder /app /app

# Creating a non root user
RUN useradd -m appuser
USER appuser

# Running the Application
CMD ["node", "app.js"]
