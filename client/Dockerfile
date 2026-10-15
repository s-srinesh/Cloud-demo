# Multi-stage build for React Frontend
# Stage 1: Build React App
FROM node:20-alpine AS build

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (legacy peer deps for React 17 + MUI)
RUN npm install --legacy-peer-deps

# Copy frontend source files
COPY . .

# Build React production bundle with memory cap for t2.micro
ENV NODE_OPTIONS="--openssl-legacy-provider --max-old-space-size=512"
RUN npm run build

# Stage 2: Production Server with Nginx
FROM nginx:alpine

# Remove default nginx static assets
RUN rm -rf /usr/share/nginx/html/*

# Copy built static files from build stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 3000
EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]
