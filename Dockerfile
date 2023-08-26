FROM python:3

# install flask python package
RUN pip install --no-cache-dir flask

# copy all app files inside the image
COPY . .

# set flask variables
ENV FLASK_APP=app
ENV FLASK_ENV=development
ENV FLASK_RUN_PORT=5000

# run flask application
RUN flask run