init-project:
	go mod init library 

build:
	go build -race -o app .

run:
	./app 

build-docker:
	docker build . --tag renegmedal/library:latest 

push:
	docker push renegmedal/library:latest 