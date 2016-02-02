NAME = kyleondy/znc
VERSION = 0.1.1

.PHONY: all
all: run

.PHONY: build
build:
	docker build -t $(NAME):$(VERSION) --rm image

.PHONY: run
run: build tag_latest
	docker run -p 12345:6667 -v /tmp/znc:/znc-data --rm $(NAME)

.PHONY: tag_latest
tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

