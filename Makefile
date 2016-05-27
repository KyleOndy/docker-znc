NAME = kyleondy/znc
VERSION = 0.1.1

.PHONY: all
all: make

.PHONY: build
build:
	docker build -t $(NAME):$(VERSION) --rm image

.PHONY: tag_latest
tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

