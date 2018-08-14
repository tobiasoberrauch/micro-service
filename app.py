from datetime import datetime

from flask import Flask, jsonify, request
from flask_compress import Compress

app = Flask(__name__)
Compress(app)


@app.route('/ping')
def ping():
    return 'pong'


@app.route('/api')
def index():
    response_data = {
        'timestamp': datetime.now()
    }

    return jsonify(response_data)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
