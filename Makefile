.PHONY: default build install test bash

default: build install test

build:
	docker build \
            --tag behat-api-extension:php \
            --file ./docker/Dockerfile \
            --force-rm  \
            ${PWD}

install:
	docker run \
            --env COMPOSER_HOME \
            --env COMPOSER_CACHE_DIR \
            --volume ${COMPOSER_HOME:-$HOME/.config/composer}:$COMPOSER_HOME \
            --volume ${COMPOSER_CACHE_DIR:-$HOME/.cache/composer}:$COMPOSER_CACHE_DIR \
            --volume ${PWD}:/app \
            --interactive \
            --tty \
            --workdir /app \
            --rm \
            behat-api-extension:php composer install
bash:
	docker run \
            --env COMPOSER_HOME \
            --env COMPOSER_CACHE_DIR \
            --volume ${COMPOSER_HOME:-$HOME/.config/composer}:$COMPOSER_HOME \
            --volume ${COMPOSER_CACHE_DIR:-$HOME/.cache/composer}:$COMPOSER_CACHE_DIR \
            --volume ${PWD}:/app \
            --interactive \
            --tty \
            --workdir /app \
            --rm \
            behat-api-extension:php bash

test:
	docker run \
            --env COMPOSER_HOME \
            --env COMPOSER_CACHE_DIR \
            --volume ${COMPOSER_HOME:-$HOME/.config/composer}:$COMPOSER_HOME \
            --volume ${COMPOSER_CACHE_DIR:-$HOME/.cache/composer}:$COMPOSER_CACHE_DIR \
            --volume ${PWD}:/app \
            --interactive \
            --tty \
            --workdir /app \
            --rm \
            behat-api-extension:php php vendor/bin/phpunit
