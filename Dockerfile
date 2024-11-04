# Stage 1: Build the React app and Netlify functions
FROM node:18 as build

WORKDIR /app
COPY . .

# Install dependencies
RUN npm install

# Build React and Lambda functions
RUN npm run build

# Stage 2: Serve the app with a lightweight server
FROM nginx:alpine

# Copy the React app's build output to the Nginx public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]