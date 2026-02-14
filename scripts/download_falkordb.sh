#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/falkordb_bin/bin"
mkdir -p "${BIN_DIR}"

FALKORDB_VERSION="${FALKORDB_VERSION:-v4.16.3}"
FALKORDB_ASSET="${FALKORDB_ASSET:-}"
OS_NAME="$(uname -s)"
ARCH_NAME="$(uname -m)"

if [[ -z "${FALKORDB_ASSET}" ]]; then
  case "${OS_NAME}" in
    Linux)
      case "${ARCH_NAME}" in
        x86_64) ASSET="falkordb-x64.so" ;;
        aarch64|arm64) ASSET="falkordb-arm64v8.so" ;;
        *) echo "Unsupported Linux arch: ${ARCH_NAME}"; exit 1 ;;
      esac
      ;;
    Darwin)
      case "${ARCH_NAME}" in
        arm64) ASSET="falkordb-macos-arm64v8.so" ;;
        *)
          echo "Unsupported macOS arch for default mapping: ${ARCH_NAME}"
          echo "Set FALKORDB_ASSET explicitly if a matching release artifact exists."
          exit 1
          ;;
      esac
      ;;
    *)
      echo "Unsupported OS: ${OS_NAME}"
      exit 1
      ;;
  esac
else
  ASSET="${FALKORDB_ASSET}"
fi

if [[ "${OS_NAME}" == "Darwin" ]]; then
  TARGET="${BIN_DIR}/falkordb.dylib"
else
  TARGET="${BIN_DIR}/falkordb.so"
fi

URL="https://github.com/FalkorDB/FalkorDB/releases/download/${FALKORDB_VERSION}/${ASSET}"

echo "Downloading ${URL}"
curl --fail --location --silent --show-error -o "${TARGET}" "${URL}"
chmod +x "${TARGET}"
