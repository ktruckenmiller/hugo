FROM alpine:latest

RUN apk add --no-cache \
    curl \
    git \
    openssh-client \
    rsync

ARG VERSION
ENV VERSION=$VERSION
RUN echo $VERSION

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -L https://github.com/gohugoio/hugo/releases/download/v${VERSION}/hugo_${VERSION}_linux-64bit.tar.gz | tar -xz && \
    mv hugo /usr/local/bin/hugo && \
    curl -L https://bin.equinox.io/c/dhgbqpS8Bvy/minify-stable-linux-amd64.tgz | tar -xz && \
    mv minify /usr/local/bin/ && \
    addgroup -Sg 1000 hugo && \
    adduser -SG hugo -u 1000 -h /src hugo

WORKDIR /work

EXPOSE 1313
