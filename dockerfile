# FROM node:20.18-alpine3.19 as build

# WORKDIR /app

# COPY . .

# RUN npm install

# RUN npm run build

# FROM node:20.18-alpine3.19

# WORKDIR /app

# COPY --from=build /app/dist /app/dist

# EXPOSE 80
# CMD ["node", "dist/index.js"]

FROM node:20.18-alpine3.19 as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Use the lightweight Nginx image from the previous stage for the nginx container
FROM nginx:stable-alpine as production-stage

# Copy the build application from the previous stage to the Nginx container
COPY --from=build-stage /app/dist/ /usr/share/nginx/html

# Copy the nginx configuration file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Expose the port 80
EXPOSE 80

# Start Nginx to serve the application
CMD ["nginx", "-g", "daemon off;"]