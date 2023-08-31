from flask import Flask, render_template, request
from pymongo import MongoClient

app = Flask(__name__)

client = MongoClient("mongodb://mongo:27017/")
db = client['base']
collection = db['collection']

@app.route('/')
def index():
	return render_template('index.html')

@app.route('/', methods=['PUT'])
def put():
	app.logger.info('I am getting a PUT request!')
	if request.method == 'PUT':
		data = request.get_json()
		if data is not None:
			app.logger.info(f'Received data: {data}')
			collection.insert_one(data)
			return {'message': 'Data received'}, 200
		else:
			return {'message': 'No data provided'}, 400


if __name__ == '__main__':
	for record in collection.find():
		print(record)
	
	app.run(host='0.0.0.0', port=5000)