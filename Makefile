.DEFAULT_TARGET: init
.PHONY: init code outdated upgrade analyze format format-ci test

MAKEFLAGS = --no-print-directory
ROOT = $(shell git rev-parse --show-toplevel)
ARGS ?=

init:
	@find $(ROOT) -name pubspec.yaml -execdir bash -c "pwd && flutter pub get" \;

code:
	@code $(ROOT)/.vscode/flutter_app_info.code-workspace

outdated:
	@dart pub outdated $(ARGS)

upgrade:
	@dart pub upgrade $(ARGS)

analyze:
	@dart analyze $(ARGS)

format:
	@dart format lib
	@dart fix --apply

publish:
	@dart pub publish --dry-run