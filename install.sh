#!/usr/bin/env bash

#イメージ作成
cp -p dns.go tmpdns/dns.go
cd tmpdns
docker build . -t tmpdns
cd ..

git clone https://github.com/Neilpang/acme.sh.git
cp ./dns_tmpdns.sh ./acme.sh/dnsapi/
cd acme.sh
./acme.sh --install
