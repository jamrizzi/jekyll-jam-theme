CWD := $(shell pwd)

.PHONY: all
all: clean build

.PHONY: start
start: deps clean
	@bundle exec jekyll serve --verbose

.PHONY: build
build: deps clean _site
	@echo ::: BUILD :::
_site:
	@gem build material-theme.gemspec
	@bundle exec jekyll build

.PHONY: install
install: deps
	-@rm -f Gemfile.lock &>/dev/null || true
	@bundle install
	@echo ::: INSTALL :::

.PHONY: push
push: deps
	@gem push jekyll-jam-theme-0.1.0.gem
	@echo ::: PUSH :::

.PHONY: clean
clean:
	-@rm -rf _site &>/dev/null || true
	@echo ::: CLEAN :::

.PHONY: deps
deps: bundle
	@echo ::: DEPS :::
.PHONY: bundle
bundle:
	@if ! o=$$(which bundle); then gem install bundle jekyll; fi
