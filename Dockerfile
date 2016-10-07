FROM node:6
MAINTAINER shawn

ADD . /app

CMD ["node", "index.js"]