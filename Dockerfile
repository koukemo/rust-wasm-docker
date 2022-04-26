FROM ubuntu:20.04

EXPOSE 4507
ENV DEBIAN_FRONTEND=noninteractive

# install apt packages
RUN apt-get update && \
    apt-get install -y curl gcc libssl-dev pkg-config build-essential python3 vim && \
    apt-get -y install python-is-python3

# install Rust
RUN curl -L https://sh.rustup.rs | sh -s -- -y --default-toolchain=nightly
ENV PATH=$PATH:~/.cargo/bin

RUN ~/.cargo/bin/rustup update
RUN ~/.cargo/bin/rustup target add wasm32-unknown-unknown --toolchain nightly
RUN ~/.cargo/bin/cargo install --git https://github.com/alexcrichton/wasm-gc
RUN ~/.cargo/bin/cargo install deno --locked
RUN ~/.cargo/bin/cargo install wasm-pack
RUN ~/.cargo/bin/cargo install cargo-generate
RUN ~/.cargo/bin/cargo install wasm-bindgen-cli

ENV USER=koukemo

WORKDIR /var/workspace

CMD python3 -m http.server 8081