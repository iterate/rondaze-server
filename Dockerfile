FROM node:20-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy source code
COPY src/ ./src/

# Expose the port the app runs on
EXPOSE 3002

# Start the server
CMD ["npm", "start"]
