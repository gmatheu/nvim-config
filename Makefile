
build-image:
	docker build -t nvim-config .

run-image:
	docker run -it nvim-config /bin/bash
