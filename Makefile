IMAGE_NAME ?= maru_rethink_todo

build:
	@docker build -t $(IMAGE_NAME) .
.PHONY: build

shell:
	@docker run --rm -it \
              -v $(PWD):/usr/local/maru \
              --link maru_db:db \
              $(IMAGE_NAME) bash
.PHONY: shell

test:
	@docker run --rm -it \
              -v $(PWD):/usr/local/maru \
              $(IMAGE_NAME) mix test
.PHONY: test

app:
	@docker run -d -it \
              -p 8880:8880 \
              --link maru_db:db \
              --name maru_app \
              $(IMAGE_NAME)
.PHONY: app

db:
	@docker run -d \
              -p 8080:8080 \
              --name maru_db \
              rethinkdb:2.2
.PHONY: db

install: db app
.PHONY: install

clean:
	@docker rm -vf maru_app maru_db
.PHONY: clean
