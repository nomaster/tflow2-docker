FROM golang as builder
EXPOSE 2055/udp
EXPOSE 4739/udp
EXPOSE 6343/udp
EXPOSE 4444
ENV CGO_ENABLED=0
RUN go get github.com/taktv6/tflow2

FROM scratch
CMD ["/go/bin/tflow2","-logtostderr"]
WORKDIR /
VOLUME /data
COPY --from=builder /go/bin/tflow2 /go/bin/
COPY --from=builder /go/src/github.com/taktv6/tflow2/tflow2.css /
COPY --from=builder /go/src/github.com/taktv6/tflow2/tflow2.html /
COPY --from=builder /go/src/github.com/taktv6/tflow2/tflow2.js /
COPY config.yml /
