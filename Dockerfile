# Use a smaller base image
FROM node:14-slim

WORKDIR /app

# Copy only package.json and package-lock.json first to take advantage of caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Now copy the rest of the application code
COPY server.js . 


# COPY images ./images
# Commented this to check if s3 connection works


COPY css ./css
COPY js ./js
COPY public ./public

# Expose the port
EXPOSE 3000

# Run the application
CMD ["node", "server.js"]
