.PHONY: fetch-linux clean

LINUX_VERSION := 4.0
LINUX_DIR := vendor/linux-$(LINUX_VERSION)

fetch-linux:
	./scripts/fetch-linux-4.0.sh

clean:
	rm -rf vendor/linux-$(LINUX_VERSION)
