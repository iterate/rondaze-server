FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy source code
COPY src/ ./src/

# Expose the port Cloud Run expects (can be overridden by PORT env var)
EXPOSE 8080

# Start the server
CMD ["npm", "start"]
