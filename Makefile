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
	@flutter pub outdated $(ARGS)

upgrade:
	@flutter pub upgrade $(ARGS)

analyze:
	@flutter analyze $(ARGS)

format:
	@dart format lib
	@dart fix --apply

format-ci:
	@dart format lib --set-exit-if-changed

test:
	@flutter test -r expanded $(ARGS)

publish:
	@flutter pub publish --dry-run