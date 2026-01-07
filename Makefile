.PHONY: image publish

IMAGE_NAME=mortbauer/distrust
now=$(shell date +'%Y-%m-%d-%H-%M')
IMAGE_TAG=$(now)

image:
	docker build --tag ${IMAGE_NAME}:${IMAGE_TAG} --platform linux/arm64,linux/amd64 .
	docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME} 

publish:
	docker push ${IMAGE_NAME}:${IMAGE_TAG}
	docker push ${IMAGE_NAME}
