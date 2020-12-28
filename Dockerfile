FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

ENV POST 80

EXPOSE $POST

CMD [ "npm", "start" ]