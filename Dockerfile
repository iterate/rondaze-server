# ---- Build Stage ----
  FROM node:20-alpine AS build

  WORKDIR /
  
  COPY package*.json ./
  RUN npm install
  
  COPY . .
  RUN npm run build
  
  # ---- Production Stage ----
  FROM nginx:alpine
  
  RUN rm -rf /usr/share/nginx/html/*
  COPY --from=build /build /usr/share/nginx/html
  COPY nginx.conf /etc/nginx/conf.d/default.conf
  
  EXPOSE 8080
  CMD ["nginx", "-g", "daemon off;"]
  
