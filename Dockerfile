FROM node:9.5-alpine

RUN apk add --update --no-cache git
RUN npm config set unsafe-perm true
    && npm install hexo-cli -g

WORKDIR /Hexo

EXPOSE 4000