generate:
	docker run --rm -ti \
		--env-file ovh.env \
		-v $$(pwd):/play --workdir /play \
		krkr/dops-spawner test

dev:
	doo d -v $$(pwd):/play --workdir /play --entrypoint bash