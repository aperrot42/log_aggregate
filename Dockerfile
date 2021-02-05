ARG RUST_VERSION=1.48
ARG APP_NAME=toto

FROM rust:${RUST_VERSION} as builder
WORKDIR /app
ADD . /app
RUN cargo fetch
RUN cargo build --release

FROM alpine:latest
ARG APP_NAME
ENV APP_NAME ${APP_NAME}

COPY --from=builder /app/target/release/${APP_NAME} /
RUN echo ${APP_NAME}
RUN ls
ENTRYPOINT /bin/sh exec ${APP_NAME}
