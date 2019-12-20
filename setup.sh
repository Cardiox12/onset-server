docker build -t onset_serv .
docker rm -f onset-server-live
docker run -it -p 22600:7777/udp -p 22599:7776/udp -p 22598:7775/tcp --name onset-server-live onset_serv
