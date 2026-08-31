#!/bin/sh
set -eu

VERSION=4.0
ARCHIVE="linux-${VERSION}.tar.xz"
URL="https://cdn.kernel.org/pub/linux/kernel/v4.x/${ARCHIVE}"
ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
VENDOR_DIR="${ROOT}/vendor"
SRC_DIR="${VENDOR_DIR}/linux-${VERSION}"
ARCHIVE_PATH="${VENDOR_DIR}/${ARCHIVE}"

mkdir -p "${VENDOR_DIR}"

if [ ! -f "${ARCHIVE_PATH}" ]; then
    echo "Downloading ${URL}"
    curl -L --fail --retry 3 -o "${ARCHIVE_PATH}.tmp" "${URL}"
    mv "${ARCHIVE_PATH}.tmp" "${ARCHIVE_PATH}"
fi

if [ ! -d "${SRC_DIR}" ]; then
    echo "Extracting ${ARCHIVE}"
    tar -xJf "${ARCHIVE_PATH}" -C "${VENDOR_DIR}"
fi

echo "Linux ${VERSION} source: ${SRC_DIR}"
echo "Next: apply the Saturn SH-2 patches from patches/"
