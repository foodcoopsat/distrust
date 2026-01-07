FROM --platform=linux/amd64 golang:1.25-trixie AS builder

WORKDIR /build

COPY auth auth
COPY cryptutils cryptutils
COPY discourse discourse
COPY requestlog requestlog
COPY go.mod go.sum main.go genkey.go ./

ARG TARGETOS
ARG TARGETARCH
ENV GOOS=$TARGETOS
ENV GOARCH=$TARGETARCH

RUN go build

# Use distroless as minimal base image to package the distrust binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /build/distrust /
USER nonroot:nonroot

EXPOSE 3000

ENTRYPOINT ["/distrust"]
