FROM python:3-alpine

ARG ENDPOINT

# install flask python package
RUN pip install --no-cache-dir flask
RUN pip install --no-cache-dir pymongo

# copy all app files inside the image
COPY . .

# set flask application variable
ENV FLASK_APP=app
ENV FLASK_DEBUG=1
ENV WEBSERVER_ENDPOINT=${ENDPOINT}

CMD python app.py $WEBSERVER_ENDPOINT
# CMD [ "python", "app.py", ${WEBSERVER_ENDPOINT} ]