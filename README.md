# aws-msk-terraform
-- note: express borker not support log to cloud watch and ebs storage, and the following cluster configuration:
default.replication.factor=3 
min.insync.replicas=2 
num.io.threads=8 
num.network.threads=5 
num.replica.fetchers=2 
replica.lag.time.max.ms=30000 
unclean.leader.election.enable=true 
zookeeper.session.timeout.ms=18000 
