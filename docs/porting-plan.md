# Porting plan

## Kernel base

The initial base is Linux 4.0.

Linux 4.x already contains the SuperH architecture support under `arch/sh`, so the Saturn port should reuse the existing SH infrastructure rather than inventing a CPU architecture from scratch.

## Saturn-specific work

The Sega Saturn uses two Hitachi SH-2 CPUs. The first milestone deliberately targets one SH-2 only. SMP can be added after basic boot works.

Initial platform work:

1. Select the appropriate SH-2 CPU configuration.
2. Add a Saturn machine/platform configuration.
3. Add early startup code and memory initialization.
4. Add interrupt/timer support required by the kernel.
5. Establish a debug output path.
6. Add Saturn memory-map definitions.
7. Only after single-CPU boot works, investigate the second SH-2.

## Source import

Do not vendor a generated or modified Linux tree into the project until the exact upstream 4.0 source revision is chosen. The canonical Linux 4.0 source archive is published by kernel.org.

For development, keep the upstream source in a separate working tree and apply Saturn-specific changes as patches or a Git branch. This keeps the port reviewable and makes it easier to compare against pristine Linux 4.0.
