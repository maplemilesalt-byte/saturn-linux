// SPDX-License-Identifier: GPL-2.0
/*
 * Sega Saturn machine setup
 *
 * Initial Linux 4.x bring-up skeleton. Keep this file deliberately small:
 * CPU/cache support belongs to the generic SH-2 code; Saturn-specific
 * devices will be added incrementally once the kernel entry path works.
 */

#include <linux/init.h>
#include <asm/machvec.h>

static void __init saturn_setup(char **cmdline_p)
{
	/* TODO: install Saturn-specific early platform initialization. */
}

static struct sh_machine_vector mv_saturn __initmv = {
	.mv_name		= "Sega Saturn",
	.mv_setup		= saturn_setup,
};

SH_MACHINE_VECTOR(SATURN, mv_saturn)
