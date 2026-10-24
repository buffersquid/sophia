.DEFAULT_GOAL := help

.PHONY: help link format

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  link    Symlink application configs into ~/.config"
	@echo "  format  Format Scheme files"

link:
	@./scripts/link-configs

format:
	@./scripts/format-scheme
