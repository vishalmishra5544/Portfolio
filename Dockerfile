# Stage 1: Build Angular app
FROM node:18-alpine AS builder
WORKDIR /app

COPY portfolio-app/package.json portfolio-app/package-lock.json ./
RUN npm ci

COPY portfolio-app/ ./
RUN npm run build -- --configuration production --base-href "/portfolio-app/"

# Stage 2: Serve only the browser build (static site)
FROM nginx:alpine
COPY --from=builder /app/dist/portfolio-app/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
