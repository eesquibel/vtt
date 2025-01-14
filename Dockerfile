ARG NODE_VERSION=20-alpine

FROM alpine AS extract

ARG VERSION=11.313

RUN apk add --no-cache unzip

ADD FoundryVTT-${VERSION}.zip /tmp/foundry.zip

RUN unzip /tmp/foundry.zip -d /tmp/foundry

FROM node:${NODE_VERSION}

COPY --from=extract /tmp/foundry/resources/app /opt/foundry

VOLUME [ "/data" ]

WORKDIR /opt/foundry

EXPOSE 30000

CMD ["node", "/opt/foundry/main.js", "--dataPath=/data"]
