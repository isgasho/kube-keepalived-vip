all: push

# 0.0 shouldn't clobber any release builds
TAG = 0.0
PREFIX = aledbf/kube-bgp-vip

controller: clean
	CGO_ENABLED=0 GOOS=linux godep go build -a -installsuffix cgo -ldflags '-w' -o kube-bgp-vip

container: controller
	docker build -t $(PREFIX):$(TAG) .

push: container
	docker push $(PREFIX):$(TAG)

clean:
	rm -f kube-bgp-vip
