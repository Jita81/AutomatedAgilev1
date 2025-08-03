# AutomatedAgilev1 - AI-Driven Development Pipeline
# Multi-stage Docker build for development environment

FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    git \
    bash \
    curl \
    jq \
    python3 \
    py3-pip \
    make \
    g++

# Install global tools
RUN npm install -g \
    @vercel/ncc \
    typescript \
    ts-node \
    nodemon \
    concurrently

# Development stage
FROM base AS development

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Set environment
ENV NODE_ENV=development
ENV BRANCH_CONTEXT=main

# Expose ports
EXPOSE 3000 8080 9229

# Start development server
CMD ["npm", "run", "dev"]

# Production stage  
FROM base AS production

# Copy package files
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy built application
COPY --from=development /app/dist ./dist
COPY --from=development /app/docs ./docs
COPY --from=development /app/deployment ./deployment

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S automatedagile -u 1001
USER automatedagile

# Set environment
ENV NODE_ENV=production
ENV PORT=3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Start production server
CMD ["npm", "start"]