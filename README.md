# FlaskMinimalWebapp_dev

- Use `>python3 app.py` to run app localy without containerization - best for API/frontend development. Web server will be hosted at `http://0.0.0.0:5000/`.  
⚠️ Warning! Features like database will not be accessible

- Use `>./local_deploy.sh` to run containerized solution on the local machine. Database and other infrastructure is created and accessible. Web server will be hosted at `http://0.0.0.0:5000/`. 

- Use `>./build_n_rerun.sh` to rebuild an app image and run it, stoping and removing previous containers running this image. 