# Saturn Linux

Experimental Linux 4.0 port for the Sega Saturn.

## Goal

Bring a real Linux kernel to the Sega Saturn's dual Hitachi SH-2 architecture, starting with a minimal single-CPU bring-up and adding Saturn-specific platform support incrementally.

## Base

This project targets **Linux 4.0** as its initial kernel base. The upstream Linux 4.0 source is available from kernel.org.

## Current findings

Linux 4.0 already contains a usable SH-2 CPU backend under `arch/sh/kernel/cpu/sh2/`, including the generic SH-2 entry, exception, and probe code. The SH-2 memory-management path is explicitly designed for no-MMU CPUs. We will reuse this generic code and add a Saturn-specific machine layer rather than copying an unrelated SH board.

See [`docs/linux-4.0-sh2-config.md`](docs/linux-4.0-sh2-config.md) for the configuration analysis.

## Roadmap

- [ ] Import Linux 4.0 source tree
- [x] Identify reusable SH-2 architecture code and minimum Kconfig requirements
- [ ] Add a Saturn CPU subtype/platform configuration
- [ ] Establish an SH-2 cross-compilation toolchain
- [ ] Create the Saturn machine/platform layer
- [ ] Boot a minimal kernel on an SH-2
- [ ] Initialize Saturn RAM and interrupts
- [ ] Add a Saturn debug console/output path
- [ ] Bring up the second SH-2 as SMP
- [ ] Add storage and input drivers
- [ ] Boot a minimal userspace

## Status

Early research / bring-up.
