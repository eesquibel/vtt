ARG NODE_VERSION=22-alpine

FROM alpine AS extract

ARG VERSION=Node-13.351

RUN apk add --no-cache unzip

ADD FoundryVTT-${VERSION}.zip /tmp/foundry.zip

RUN unzip /tmp/foundry.zip -d /tmp/foundry

FROM node:${NODE_VERSION}

ARG COPY_DIR= # VTT <= 12, use /resources/app, VTT >= 13, leave empty

COPY --from=extract /tmp/foundry${COPY_DIR} /opt/foundry

VOLUME [ "/data" ]

WORKDIR /opt/foundry

EXPOSE 30000

CMD ["node", "/opt/foundry/main.js", "--dataPath=/data"]
