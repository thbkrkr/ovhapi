dops-creator:
	docker run --rm -ti \
		--env-file ovh.env \
		-v $$(pwd):/play --workdir /play \
		krkr/ovhapi dops-creator

dev:
	@doo d -v $$(pwd):/play --workdir /play --entrypoint bash
