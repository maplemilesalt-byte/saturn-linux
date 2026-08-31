# Linux 4.0 SH-2 configuration for Saturn

This document records the minimum `arch/sh` configuration identified from Linux 4.0 for the Sega Saturn bring-up.

## Reuse from upstream

- `arch/sh/kernel/head_32.S`
- `arch/sh/kernel/entry-common.S`
- `arch/sh/kernel/cpu/sh2/entry.S`
- `arch/sh/kernel/cpu/sh2/ex.S`
- `arch/sh/kernel/cpu/sh2/probe.c`
- `arch/sh/mm/cache-sh2.c`
- generic `arch/sh/kernel/` and `arch/sh/mm/` code where its dependencies are compatible with a no-MMU SH-2

Linux 4.0's SH-2 Makefile builds `ex.o`, `probe.o`, and `entry.o` for every SH-2 target. The SH7619 setup/clock files are conditional and must **not** be reused as Saturn hardware support.

## CPU Kconfig

Linux 4.0 defines `CPU_SH2`, which selects `SH_INTC`. The existing SH-2 subtype in that release is `CPU_SUBTYPE_SH7619`, which also enables `SYS_SUPPORTS_SH_CMT`; that is specific to the SH7619 and should not be selected for Saturn.

The Saturn should get a new subtype, for example:

```text
config CPU_SUBTYPE_SEGA_SATURN
    bool "Support Sega Saturn SH-2"
    select CPU_SH2
```

The exact symbol name can be changed before the first upstream-style patch is finalized.

## MMU / memory model

The SH-2 path is explicitly no-MMU in Linux 4.0: `CONFIG_MMU` depends on `!CPU_SH2`. Therefore Saturn should leave MMU disabled.

Relevant defaults/choices from `arch/sh/mm/Kconfig`:

- `PAGE_OFFSET = 0x00000000` when MMU is disabled
- `32BIT` defaults to `y` when MMU is disabled
- `ARCH_FLATMEM_ENABLE` is enabled when NUMA is disabled
- 4 KiB pages are the normal default; Linux 4.0 also permits 8/16/64 KiB pages on no-MMU targets
- SH-2 defaults to write-through cache mode

For the first Saturn build, keep the default 4 KiB page size and avoid optional memory-management features.

## CPU features to leave disabled

The Saturn SH-2 does not need the SH-4-only features in this path:

- `SH_FPU`
- `SH_DSP`
- `SH_STORE_QUEUES`
- SH-3/SH-4 MMU features
- PMB/X2TLB
- NUMA

`CPU_SH2` itself only selects the SuperH interrupt controller infrastructure in Linux 4.0.

## Board/platform layer

Do not reuse `arch/sh/boards/mach-dreamcast`: the Dreamcast is SH-4 based. It is useful as an architectural example of a Sega console machine directory, but Saturn needs its own machine code.

Proposed structure:

```text
arch/sh/boards/mach-saturn/
    Kconfig
    Makefile
    setup.c
    irq.c          # later
    time.c         # later
```

The initial `setup.c` should only establish the machine/platform identity and the minimum resources needed to reach the kernel initialization path. Saturn-specific interrupt, timer, VDP, SCSP, SMPC, and CD-ROM support should be added incrementally.

## First milestone

Build a single-CPU, no-MMU Linux 4.0 kernel for the Saturn SH-2. Do not attempt SMP or full device support until the first CPU can execute the kernel entry path reliably.
