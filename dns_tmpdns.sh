#!/bin/bash

#Usage: dns_tmpdns_add   _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
dns_tmpdns_add() {
  echo "set env"
  fulldomain=$1
  txtvalue=$2

  _debug "docker run"

  echo "set docker env"
  exists=`docker inspect -f '{{.Config.Cmd}}' tmpdns | awk '{print substr($0, 3,length($0)-4)}'` || true
  echo "rm docker container"
  docker rm -f tmpdns || true
  echo "docker run"
  docker run -d -p 53:53/udp --name tmpdns tmpdns $exists "$fulldomain.:txt:$txtvalue"
  echo "end dns_tmpdns_add"
}

#Usage: fulldomain txtvalue
#Remove the txt record after validation.
dns_tmpdns_rm() {
  fulldomain=$1
  txtvalue=$2
  echo "docker stop"
  docker stop tmpdns
  echo "rm docker container"
  docker rm -f tmpdns || true
  echo "end dns_tmpdns_rm"
}

