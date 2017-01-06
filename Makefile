NAME = kyleondy/znc
VERSION = 0.3.0

.PHONY: all
all: build

.PHONY: build
build:
	docker build -t $(NAME):$(VERSION) --rm image

.PHONY: tag_latest
tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

