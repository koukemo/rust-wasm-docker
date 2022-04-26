FROM ubuntu:20.04

EXPOSE 8081
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y curl gcc libssl-dev pkg-config build-essential python3 && \
    apt-get -y install python-is-python3

# install Rust
RUN curl -L https://sh.rustup.rs | sh -s -- -y --default-toolchain=nightly
ENV PATH=$PATH:~/.cargo/bin

RUN ~/.cargo/bin/rustup update
RUN ~/.cargo/bin/rustup target add wasm32-unknown-unknown --toolchain nightly
RUN ~/.cargo/bin/cargo install --git https://github.com/alexcrichton/wasm-gc
RUN ~/.cargo/bin/cargo install deno --locked

WORKDIR /var/workspace

CMD python3 -m http.server 8081