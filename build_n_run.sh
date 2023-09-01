sudo docker rm webserver
sudo docker build -t flask_webserver .
sudo docker run --name webserver -p 80:5000 flask_webserver
