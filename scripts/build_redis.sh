#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/falkordb_bin/bin"
mkdir -p "${BIN_DIR}"

REDIS_VERSION="${REDIS_VERSION:-8.2.3}"
TARBALL="redis-${REDIS_VERSION}.tar.gz"
SRC_DIR="redis-${REDIS_VERSION}"
URL="https://github.com/redis/redis/archive/refs/tags/${REDIS_VERSION}.tar.gz"

echo "Downloading Redis ${REDIS_VERSION}"
curl --fail --location --silent --show-error -o "${TARBALL}" "${URL}"

tar xzf "${TARBALL}"
cd "${SRC_DIR}"

if command -v nproc >/dev/null 2>&1; then
  JOBS="$(nproc)"
else
  JOBS="$(sysctl -n hw.ncpu)"
fi

make redis-server -j"${JOBS}"
cp src/redis-server "${BIN_DIR}/redis-server"
chmod +x "${BIN_DIR}/redis-server"
