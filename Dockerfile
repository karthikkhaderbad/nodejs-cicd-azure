# first stage build
FROM node:18-alpine AS build

WORKDIR /app

# copy only the dependency files
COPY package*.json ./

# install dependencies ,  using ci so that it takes exact versions in package-lock.json
RUN npm ci --only=production

# Copy source code
COPY . .

# Stage 2: fina image
FROM node:18-alpine

WORKDIR /app

# Copy onlynode_modules and main code file from build stage
COPY --from=build /app/app.js ./app.js
COPY --from=build /app/node_modules ./node_modules

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
