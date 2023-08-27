from flask import Flask, render_template, request

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/', methods=['PUT'])
def put():
    if request.method == 'PUT':
        data = request.get_json()
        if data is not None:
            print(data)
            return 'Data received and processed'
        else:
            return 'No data provided', 400
