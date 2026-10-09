#!/usr/bin/env bash
# Story の基準画像 (golden) を、CI と同じ Linux 環境の Docker コンテナ内で更新する。
#
# ホストの .dart_tool などを汚さないよう、Git 管理下のファイルだけをコンテナへコピーして実行し、
# 生成された基準画像のみをホストへ書き戻す。
set -euo pipefail

cd "$(dirname "$0")/.."

if ! docker info >/dev/null 2>&1; then
  echo "Docker デーモンに接続できません。Docker Desktop などを起動してから再実行してください。" >&2
  exit 1
fi

flutter_version="$(sed -n 's/^flutter = "\(.*\)"$/\1/p' mise.toml)"
golden_dir="apps/dotto/test/widgetbook/goldens"
image="dotto-golden:${flutter_version}"
archive="$(mktemp)"
trap 'rm -f "${archive}"' EXIT

# 2 回目以降は Docker のレイヤーキャッシュが効くため、すぐに終わる。
docker build \
  --build-arg "FLUTTER_VERSION=${flutter_version}" \
  -t "${image}" \
  -f scripts/golden.Dockerfile \
  scripts

git ls-files -co --exclude-standard -z \
  | COPYFILE_DISABLE=1 tar --no-mac-metadata --no-xattrs --null -T - -cf - \
  | docker run --rm -i "${image}" \
      bash -c "
        set -euo pipefail
        mkdir -p /work && cd /work && tar --warning=no-unknown-keyword -xf - >&2
        flutter pub get >&2
        cd apps/dotto
        dart run build_runner build --delete-conflicting-outputs >&2
        rm -rf test/widgetbook/goldens
        flutter test --update-goldens --tags golden test/widgetbook >&2
        tar -cf - test/widgetbook/goldens
      " \
  > "${archive}"

rm -rf "${golden_dir}"
tar -xf "${archive}" -C apps/dotto
