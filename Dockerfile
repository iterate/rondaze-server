FROM node:20-alpine

# Install build dependencies
RUN apk add --no-cache python3 make g++

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies first (including dev dependencies if needed for build)
RUN npm ci

# Copy source code
COPY . .

# Build the application if there's a build script
RUN if npm run | grep -q "build"; then npm run build; fi

# Remove dev dependencies for production
RUN npm prune --production

# Use non-root user for security
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

# Cloud Run will set PORT environment variable
# Make sure your app listens on process.env.PORT || 8080
EXPOSE 8080

CMD ["npm", "start"]