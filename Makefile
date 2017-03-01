dops-creator:
	docker run --rm -ti \
		--env-file ovh.env \
		-v $$(pwd):/play --workdir /play \
		krkr/ovhapi-repl dops-creator

dev:
	docker run --rm -ti \
		--env-file qaas.env \
		-v $$(pwd):/play --workdir /play \
		krkr/ovhapi-repl
