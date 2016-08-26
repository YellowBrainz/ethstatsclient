STATSCLIENT_NAME=eth_repclient_local
NETWORKID=42
RPCPORT1=8545
RPCPORT2=8546
SERVPORT=3000
SUBNET=203.0.1
AUTHOR=tleijtens
VERSION=latest

build:
	docker build -t icec/ethstatsclient:latest .

network:
	docker network create --subnet $(SUBNET).0/24 --gateway $(SUBNET).254 iceclab

statsclient:
	docker run -i -t --net iceclab --ip $(SUBNET).13 -p $(SERVPORT) -p $(RPCPORT1) -p $(RPCPORT2) -p 30303 --name $(STATSCLIENT_NAME) icec/ethstatsclient:latest

rmstatsclient:
	docker rm -f $(STATSCLIENT_NAME)

rmnetwork:
	docker network rm iceclab
