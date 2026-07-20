#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DIST_DIR="$REPO_ROOT/dist/qemu-aarch64"

QEMU_BIN="${QEMU_BIN:-qemu-system-aarch64}"
KERNEL_IMAGE="$DIST_DIR/Image"
ROOTFS_IMAGE="$DIST_DIR/rootfs.ext2"

if ! command -v "$QEMU_BIN" >/dev/null 2>&1; then
  printf 'error: %s was not found in PATH\n' "$QEMU_BIN" >&2
  exit 1
fi

for image in "$KERNEL_IMAGE" "$ROOTFS_IMAGE"; do
  if [[ ! -s "$image" ]]; then
    printf 'error: required image is missing or empty: %s\n' "$image" >&2
    printf 'run ./scripts/build.sh first\n' >&2
    exit 1
  fi
done

printf 'Starting Folune. To exit QEMU, press Ctrl+A, release, then press x.\n'

exec "$QEMU_BIN" \
  -M virt \
  -cpu cortex-a53 \
  -smp 1 \
  -display cocoa \
  -serial mon:stdio \
  -device virtio-gpu-pci \
  -kernel "$KERNEL_IMAGE" \
  -append "rootwait root=/dev/vda console=ttyAMA0" \
  -drive "file=$ROOTFS_IMAGE,if=none,format=raw,id=hd0" \
  -device virtio-blk-device,drive=hd0 \
  -netdev user,id=eth0 \
  -device virtio-net-device,netdev=eth0
