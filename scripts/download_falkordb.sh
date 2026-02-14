#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/falkordb_bin/bin"
mkdir -p "${BIN_DIR}"

FALKORDB_VERSION="${FALKORDB_VERSION:-v4.16.3}"
OS_NAME="$(uname -s)"
ARCH_NAME="$(uname -m)"

case "${OS_NAME}" in
  Linux)
    case "${ARCH_NAME}" in
      x86_64) ASSET="falkordb-x64.so" ;;
      aarch64|arm64) ASSET="falkordb-arm64v8.so" ;;
      *) echo "Unsupported Linux arch: ${ARCH_NAME}"; exit 1 ;;
    esac
    TARGET="${BIN_DIR}/falkordb.so"
    ;;
  Darwin)
    case "${ARCH_NAME}" in
      arm64) ASSET="falkordb-macos-arm64v8.so" ;;
      x86_64) ASSET="falkordb-macos-x64.so" ;;
      *) echo "Unsupported macOS arch: ${ARCH_NAME}"; exit 1 ;;
    esac
    TARGET="${BIN_DIR}/falkordb.dylib"
    ;;
  *)
    echo "Unsupported OS: ${OS_NAME}"
    exit 1
    ;;
esac

URL="https://github.com/FalkorDB/FalkorDB/releases/download/${FALKORDB_VERSION}/${ASSET}"

echo "Downloading ${URL}"
curl --fail --location --silent --show-error -o "${TARGET}" "${URL}"
chmod +x "${TARGET}"
