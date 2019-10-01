#!/usr/bin/env bash

#イメージ作成
docker build ./tmpdns/ -t tmpdns

git clone https://github.com/Neilpang/acme.sh.git
cp ./dns_tmpdns.sh ./acme.sh/dnsapi/
cd acme.sh
./acme.sh --install
