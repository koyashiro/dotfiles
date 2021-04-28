.PHONY: build
build: build-alpine build-archlinux build-debian build-ubuntu

.PHONY: build-alpine
build-alpine: dockerfiles/base/alpine/Dockerfile
	@docker build --file ./dockerfiles/base/alpine/Dockerfile --tag dotfiles-alpine .

.PHONY: build-archlinux
build-archlinux: dockerfiles/base/archlinux/Dockerfile
	@docker build --file ./dockerfiles/base/archlinux/Dockerfile --tag dotfiles-archlinux .

.PHONY: build-debian
build-debian: dockerfiles/base/debian/Dockerfile
	@docker build --file ./dockerfiles/base/debian/Dockerfile --tag dotfiles-debian .

.PHONY: build-ubuntu
build-ubuntu: dockerfiles/base/ubuntu/Dockerfile
	@docker build --file ./dockerfiles/base/ubuntu/Dockerfile --tag dotfiles-ubuntu .

.PHONY: test
test: test-alpine test-archlinux test-debian test-ubuntu

.PHONY: test-alpine test/test.sh dockerfiles/test/alpine/Dockerfile
test-alpine: build-alpine
	@docker build --file ./dockerfiles/test/alpine/Dockerfile --tag dotfiles-alpine-test .
	@docker run --rm -it dotfiles-alpine-test

.PHONY: test-archlinux test/test.sh dockerfiles/test/archlinux/Dockerfile
test-archlinux: build-archlinux
	@docker build --file ./dockerfiles/test/archlinux/Dockerfile --tag dotfiles-archlinux-test .
	@docker run --rm -it dotfiles-archlinux-test

.PHONY: test-debian test/test.sh dockerfiles/test/debian/Dockerfile
test-debian: build-debian
	@docker build --file ./dockerfiles/test/debian/Dockerfile --tag dotfiles-debian-test .
	@docker run --rm -it dotfiles-debian-test

.PHONY: test-ubuntu test/test.sh dockerfiles/test/ubuntu/Dockerfile
test-ubuntu: build-ubuntu
	@docker build --file ./dockerfiles/test/ubuntu/Dockerfile --tag dotfiles-ubuntu-test .
	@docker run --rm -it dotfiles-ubuntu-test

.PHONY: clean
clean:
	@docker image rm dotfiles-alpine \
	dotfiles-archlinux \
	dotfiles-debian \
	dotfiles-ubuntu \
	dotfiles-alpine-test \
	dotfiles-archlinux-test \
	dotfiles-debian-test \
	dotfiles-ubuntu-test >/dev/null 2>&1 || true
