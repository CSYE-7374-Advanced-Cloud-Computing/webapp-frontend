FROM node:12.14.1 as build-stage
WORKDIR /app
COPY ./recipes/package.json /app/package.json
COPY ./recipes/package-lock.json /app/package-lock.json
RUN npm install
RUN npm install -g @angular/cli
COPY ./recipes /app
RUN ng build --output-path=./dist/out

#stage 2
FROM nginx:1.17
COPY --from=build-stage /app/dist/out/ /usr/share/nginx/html
COPY ./recipes/nginx-custom.conf /etc/nginx/conf.d/default.conf

