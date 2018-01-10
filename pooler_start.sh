#!/bin/bash
service redis-server start
#mv /var/lib/vmpooler/vmpooler.yaml.example vmpooler.yaml
#sed -i.bkp 's/redis.company.com/localhost/g' /var/lib/vmpooler/vmpooler.yaml
#service redis-server start
/usr/bin/jruby vmpooler -s Puma -E production

