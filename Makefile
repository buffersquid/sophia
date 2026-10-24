.DEFAULT_GOAL := help

.PHONY: help link

help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Targets:"
	@echo "  link    Symlink application configs into ~/.config"

link:
	@./scripts/link-configs
