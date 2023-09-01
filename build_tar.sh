sudo docker build -t flask_webserver .
sudo docker save --output flask_webserver.tar flask_webserver
sudo chmod o+wr flask_webserver.tar
