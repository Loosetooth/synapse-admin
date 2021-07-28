# Builder
FROM node:current as builder

WORKDIR /src

COPY . /src
RUN yarn --network-timeout=100000 install
RUN yarn build


# App
FROM nginx:alpine

COPY --from=builder /src/build /app

ARG REACT_APP_SERVER
ENV REACT_APP_SERVER=$REACT_APP_SERVER

RUN rm -rf /usr/share/nginx/html \
 && ln -s /app /usr/share/nginx/html
