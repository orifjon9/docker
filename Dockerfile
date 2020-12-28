FROM node:14

ARG DEFAULT_PORT=80

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

ENV POST $DEFAULT_PORT

EXPOSE $POST

CMD [ "npm", "start" ]