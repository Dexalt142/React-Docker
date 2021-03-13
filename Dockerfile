# Build react
FROM node:12.21.0-alpine3.10 as build
WORKDIR /app
COPY . /app
RUN npm install --silent
RUN npm install react-scripts -g --silent
RUN npm run build

# Setup Nginx
FROM nginx:stable-alpine
COPY --from=build /app/build /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY docker_conf/nginx/nginx.conf /etc/nginx/conf.d
EXPOSE 80