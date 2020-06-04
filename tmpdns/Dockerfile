FROM centos:centos7 as builder


ARG go_ver="1.14"

RUN yum install -y --enablerepo centosplus tar perl openssh-server openssl-devel && \
    yum install -y gcc gcc-g++ git make mercurial openssl-devel wget tar xz xz-libs sudo

# ■ go言語
WORKDIR /opt/go
ENV GOROOT=/opt/go
ENV PATH=$PATH:$GOROOT/bin:/opt/gopackages/local/bin
ENV GOPATH=/opt/gopackages

RUN curl -O https://storage.googleapis.com/golang/go${go_ver}.linux-amd64.tar.gz
RUN tar -C /opt -xzf go${go_ver}.linux-amd64.tar.gz && \
    rm go${go_ver}.linux-amd64.tar.gz

WORKDIR /work

ADD dns.go ./dns.go
RUN go get -d
#RUN go build -o tmpdns
RUN GOCACHE=/go/.cache CGO_ENABLED=0 go build -o tmpdns -ldflags='-s -w'

FROM centos:centos7

# ■ go言語
ENV GOROOT=/opt/go
ENV PATH=$PATH:$GOROOT/bin:/opt/gopackages/local/bin
ENV GOPATH=/opt/gopackages

RUN yum install -y --enablerepo centosplus tar perl openssh-server openssl-devel && \
    yum install -y gcc gcc-g++ git make mercurial openssl-devel wget tar xz xz-libs sudo

COPY --from=builder /opt/go /opt/go
COPY --from=builder /opt/gopackages /opt/gopackages

WORKDIR /work
COPY --from=builder /work /work

ADD ./start.sh /work/start.sh
RUN chmod +x /work/start.sh

EXPOSE 53/udp

ENTRYPOINT ["/work/start.sh"]
