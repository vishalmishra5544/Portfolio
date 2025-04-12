# Stage 1: Build the Angular app
FROM node:18-alpine AS builder
WORKDIR /app
COPY Portfolio/package.json Portfolio/package-lock.json ./
RUN npm ci
COPY Portfolio/ .
RUN npm run build -- --configuration production --base-href "/Portfolio/"

# Stage 2: Serve static files
FROM nginx:alpine
COPY --from=builder /app/dist/Portfolio /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]