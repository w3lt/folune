#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DIST_DIR="$REPO_ROOT/dist/qemu-aarch64"

run_buildroot() {
  docker run --rm \
    --mount "type=bind,source=$REPO_ROOT,target=/workspace,readonly" \
    --mount "type=volume,source=folune-build-output,target=/build-output" \
    --mount "type=volume,source=folune-downloads,target=/buildroot-downloads" \
    --workdir /workspace/buildroot \
    folune-builder:dev \
    make \
    O=/build-output \
    BR2_EXTERNAL=/workspace/buildroot-external \
    BR2_DL_DIR=/buildroot-downloads \
    "$@"
}

run_buildroot folune_qemu_defconfig
run_buildroot folune-app-rebuild
run_buildroot

mkdir -p "$DIST_DIR"

docker run --rm \
  --user "$(id -u):$(id -g)" \
  --mount "type=volume,source=folune-build-output,target=/build-output,readonly" \
  --mount "type=bind,source=$DIST_DIR,target=/dist" \
  folune-builder:dev \
  sh -eu -c '
    test -s /build-output/images/Image
    test -s /build-output/images/rootfs.ext2
    cp /build-output/images/Image /dist/Image
    cp /build-output/images/rootfs.ext2 /dist/rootfs.ext2
  '

printf 'Folune images exported to %s\n' "$DIST_DIR"
ls -lh "$DIST_DIR/Image" "$DIST_DIR/rootfs.ext2"
