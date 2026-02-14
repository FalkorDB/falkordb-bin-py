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
  --help >/dev/null 2>&1 || {
  python -m pip install --disable-pip-version-check --no-cache-dir wheel
}

NEW_WHEEL="$(python -m wheel tags \
  --platform-tag "${PLATFORM_TAG}" \
  --remove \
  "${WHEEL_PATH}" | tail -n 1)"

if [[ "${NEW_WHEEL}" != /* ]]; then
  NEW_WHEEL="$(dirname "${WHEEL_PATH}")/${NEW_WHEEL}"
fi

mv "${NEW_WHEEL}" "${DEST_DIR}/"
