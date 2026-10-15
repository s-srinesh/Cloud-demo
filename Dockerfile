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

# Expose internal backend port (not exposed to outside)
EXPOSE 5000

# Environment configuration
ENV PORT=5000
ENV NODE_ENV=production

# Start application
CMD ["node", "index.js"]
