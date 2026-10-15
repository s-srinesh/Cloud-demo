# Backend Dockerfile for Student Management System
FROM node:20-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy application source code
COPY . .

# Expose backend port
EXPOSE 80

# Environment configuration
ENV PORT=80
ENV NODE_ENV=production

# Start application
CMD ["node", "index.js"]
