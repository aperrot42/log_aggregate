ARG RUST_VERSION=1.48
ARG APP_NAME=toto

FROM rust:${RUST_VERSION} as builder
WORKDIR /app
ADD Cargo.toml /app/
ADD Cargo.lock /app/
RUN cargo fetch

ADD . /app/
RUN cargo test
RUN cargo build --release

FROM gcr.io/distroless/cc
ARG APP_NAME
COPY --from=builder /app/target/release/${APP_NAME} /service
CMD ["/service"]
