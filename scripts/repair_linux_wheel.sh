#!/usr/bin/env bash
set -euo pipefail

WHEEL_PATH="${1:?wheel path is required}"
DEST_DIR="${2:?destination directory is required}"

ARCH="$(uname -m)"
case "${ARCH}" in
  x86_64) PLATFORM_TAG="manylinux_2_17_x86_64" ;;
  aarch64) PLATFORM_TAG="manylinux_2_17_aarch64" ;;
  *)
    echo "Unsupported Linux arch for wheel tag repair: ${ARCH}" >&2
    exit 1
    ;;
esac

python -m wheel tags \
  --platform-tag "${PLATFORM_TAG}" \
  --remove \
  --wheel-dir "${DEST_DIR}" \
  "${WHEEL_PATH}"

