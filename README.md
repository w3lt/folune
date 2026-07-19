# Folune

Folune is a dedicated e-reader software platform built on embedded Linux.

The current implementation targets an ARM64 QEMU `virt` machine and uses Buildroot, BusyBox, and a Rust userspace application.

## Current status

Milestone 1 provides:

- an ARM64 Linux kernel and root filesystem;
- a Rust application installed at `/usr/bin/folune-app`;
- automatic application startup through BusyBox init;
- a serial debugging shell;
- Docker-based builds on macOS;
- native macOS QEMU execution.

Folune currently prints:

```text
Folune 0.1.0
Platform: qemu-aarch64
Status: ready
```

Graphics, touch input, document rendering, security, and real hardware support are not implemented yet.

## Requirements

- macOS
- Docker Desktop
- Git
- Make
- QEMU with `qemu-system-aarch64`

QEMU can be installed through Homebrew:

```bash
brew install qemu
```

## Initial setup

Initialize the pinned Buildroot submodule and build the Linux build environment:

```bash
make setup
```

This setup is normally required only once.

## Build

```bash
make build
```

The generated runtime artifacts are exported to:

```text
dist/qemu-aarch64/Image
dist/qemu-aarch64/rootfs.ext2
```

The first clean Buildroot build can take a long time. Later builds reuse Docker named volumes for Buildroot output and downloaded sources.

## Run

```bash
make run
```

Folune boots in the current terminal. At the login prompt, use:

```text
root
```

No password is currently required.

To exit QEMU, press `Ctrl+A`, release the keys, and then press `x`.

## Application development

The Rust application is located at:

```text
crates/folune-app/src/main.rs
```

After changing it, rebuild and boot the updated image:

```bash
make build
make run
```

## Repository structure

```text
buildroot/           Pinned upstream Buildroot submodule
buildroot-external/  Folune-specific Buildroot configuration and packages
crates/folune-app/   Main Rust userspace application
docker/              Linux build environment
scripts/             Build and QEMU scripts
dist/                Generated runtime artifacts
```
