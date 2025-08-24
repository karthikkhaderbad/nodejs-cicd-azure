# Stage 1: Build
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies only (using package-lock.json for exact versions)
COPY package*.json ./
RUN npm ci --only=production

# Copy app source code
COPY . .

# Stage 2: Production image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only the built node_modules and app code from build stage
COPY --from=build /app/app.js ./app.js
COPY --from=build /app/node_modules ./node_modules

# Expose app port (change if your app uses a different port)
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
