from flask import Flask, render_template, request, jsonify
from pymongo import MongoClient
from bson.objectid import ObjectId
import json

DATABASE = True

app = Flask(__name__)

if DATABASE:
	client = MongoClient("mongodb://mongo:27017/")
	db = client['base']
	collection = db['collection']
	records = db['records']

db_stub_records = [
	{
		'title': 'Record Title 1',
		'body': 'This is a body of first record'
	},
	{
		'title': 'Record Title 2',
		'body': 'This is a body of second record'
	}]

@app.get('/records/<id>')
def record(id: str):
	record = records.find_one({ '_id': ObjectId(id)})
	return render_template('record.html', record=record)

@app.get('/create')
def create():
	return render_template('create.html')

@app.put('/create')
def create_put():
	data = request.get_json()
	if (data is not None and
		'title' in data and
		'body' in data):
		app.logger.info(f'Received record:\nTitle: {data["title"]}\nBody: {data["body"]}')
		if DATABASE:
			inserted = records.insert_one(data)
			return {'message': 'Record created', 'id': str(inserted.inserted_id)}, 200
		else:
			return {'message': 'Record created', 'id': '<SOME_ID>'}, 200
	else:
		return {'message': 'No data provided or it has unexpected structure'}, 400

	

@app.get('/')
def index():
	searchstr = request.args.get('searchstr')

	if searchstr is not None:
		cursor = records.find({ 'title': {"$regex": f".*{searchstr}.*", "$options": "i"} })
		return render_template('index.html', items=cursor, searchstr=searchstr)

	return render_template('index.html', items=records.find())

# @app.put('/')
# def index_put():
# 	data = request.get_json()
# 	if data is not None:
# 		app.logger.info(f'Received data: {data}')
# 		if DATABASE: 
# 			collection.insert_one(data)
# 		return {'message': 'Data received'}, 200
# 	else:
# 		return {'message': 'No data provided'}, 400


if __name__ == '__main__':
	app.debug = True
	app.run(host='0.0.0.0', port=5000)