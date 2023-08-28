from flask import Flask, render_template, request

app = Flask(__name__)

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
			return {'message': 'Data received'}, 200
		else:
			return {'message': 'No data provided'}, 400


if __name__ == '__main__':
	app.run(host='0.0.0.0', port=5000)