FROM golang:1.16.5-alpine AS builder 


WORKDIR /home
COPY go.mod go.sum ./  
COPY main.go  ./

RUN go build -o library

# CMD ["/home/library"]

# build a small image
FROM alpine:latest
LABEL language="golang"
 

WORKDIR /
COPY --from=builder /home/library .

ENTRYPOINT ["./library"]

 