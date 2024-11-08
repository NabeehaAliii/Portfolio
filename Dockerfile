# Stage 1: Build
FROM node:14-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy all source code
COPY . .

# Install dependencies
RUN npm install


# Stage 2: Runtime
FROM node:14-slim

# Set the working directory inside the container
WORKDIR /app

# Create a non-root user and switch to it
RUN groupadd -r nabeehagroup && useradd -r -g nabeehagroup nabeehauser
USER nabeehauser

# Copy files from the build stage
COPY --from=build --chown=nabeehauser:nabeehagroup /app .

EXPOSE 3000

# Start the production server
CMD ["npm", "start"]
