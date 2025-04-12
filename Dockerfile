# Stage 1: Build the Angular app
FROM node:18-alpine AS builder
WORKDIR /app

# Copy only the Angular app subfolder
COPY portfolio-app/package.json portfolio-app/package-lock.json ./
RUN npm ci

COPY portfolio-app/ ./
RUN npm run build -- --configuration production --base-href "/portfolio-app/"

# Stage 2: Serve static files
FROM nginx:alpine

# 🔥 Important: Ensure this path is correct!
COPY --from=builder /app/dist/portfolio-app /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
