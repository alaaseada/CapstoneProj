lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint --ignore=DL3013 --ignore=DL3006 Dockerfile

build:
	docker build -t my-app
	
run:
	docker run --name nginx-app -d -p 8080:80 my-app
	
	
all:  lint build run 
