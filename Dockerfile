FROM node:slim

WORKDIR /usr/src/mockpass
EXPOSE 80
EXPOSE 443

COPY package* ./

RUN npm ci

COPY . ./

CMD ["node", "index.js"]
