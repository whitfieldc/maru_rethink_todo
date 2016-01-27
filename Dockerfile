FROM erlang
MAINTAINER Arnau Siches <asiches@gmail.com>

ENV ELIXIR_VERSION=1.2.1
ENV ELIXIR_DIR=/usr/local/elixir
ENV PATH="$PATH:$ELIXIR_DIR/bin"

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
 && apt-get update -qqy \
 && apt-get install -qqy \
      unzip \
      locales \
 && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8
WORKDIR $ELIXIR_DIR

RUN curl -L -O https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip \
 && unzip Precompiled.zip

WORKDIR /usr/local/maru
COPY . /usr/local/maru

RUN mix local.hex --force \
 && mix deps.get

EXPOSE 8880
CMD ["mix", "run", "--no-halt"]
