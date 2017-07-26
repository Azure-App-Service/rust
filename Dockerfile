FROM buildpack-deps:jessie-curl
MAINTAINER Azure App Services Container Images <appsvc-images@microsoft.com>

COPY init_container.sh /bin/
COPY sshd_config /etc/ssh/
COPY Cargo.toml /app/
COPY src /app/src

RUN apt-get update \
  && apt-get install build-essential openssl libssl-dev -y \
  && apt-get install vim -y \
  && echo "root:Docker!" | chpasswd \
  && chmod 755 /bin/init_container.sh \
  && apt install openssh-server --no-install-recommends -y

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH ${PATH}:/root/.cargo/bin:/home/site/wwwroot

# Build the default page
WORKDIR /app
RUN ls
RUN cargo build \
  && mv target/debug/defaulthomeapp /app \
  && cargo clean

WORKDIR /home/site/wwwroot
EXPOSE 2222 8080

ENTRYPOINT [ "/bin/init_container.sh" ]
