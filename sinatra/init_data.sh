#!/bin/sh 

#curl -X POST http://localhost:9292/ip/add -d "hostname=test1.local&ip=10.10.10.1&netmask=%2F16&comment=test&iptype=used"
for i in {1..100}; do
  curl -X POST http://localhost:9292/ip/add -d "hostname=test${i}.local&ip=10.10.10.${i}&comment=$RANDOM&iptype=used"
done
