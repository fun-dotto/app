# Story の基準画像 (golden) を更新するための Linux 環境。
#
# 公開されている Flutter イメージは mise.toml で指定したバージョンのタグがあるとは限らないため、
# 公式リポジトリから同じバージョンを取得して組み立てる。
FROM ubuntu:24.04

ARG FLUTTER_VERSION

RUN apt-get update \
  && apt-get install -y --no-install-recommends ca-certificates curl git unzip xz-utils \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${FLUTTER_VERSION}" https://github.com/flutter/flutter.git /opt/flutter

ENV PATH="/opt/flutter/bin:${PATH}"

RUN flutter config --no-analytics && flutter precache --universal
