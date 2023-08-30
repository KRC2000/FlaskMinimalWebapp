FROM python:3-alpine

# install flask python package
RUN pip install --no-cache-dir flask
RUN pip install --no-cache-dir pymongo

# copy all app files inside the image
COPY . .

# set flask application variable
ENV FLASK_APP=app
ENV FLASK_DEBUG=1

CMD [ "python", "app.py" ]