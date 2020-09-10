FROM node:12.18.3-alpine

WORKDIR /user/app

COPY package.json .
COPY yarn.lock .

RUN apk update && apk add python g++ make && rm -rf /var/cache/apk/*
RUN yarn

CMD echo ok
