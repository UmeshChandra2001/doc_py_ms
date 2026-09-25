from flask import Flask, render_template, jsonify
import os

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/health")
def health():
    return jsonify({
        "status": "UP",
        "application": "Python DevOps Demo App"
    }), 200


@app.route("/api/info")
def info():
    return jsonify({
        "application": "Python DevOps Demo App",
        "version": "1.0.0",
        "environment": os.getenv("APP_ENV", "development"),
        "message": "Application is running successfully"
    })


if __name__ == "__main__":
    port = int(os.getenv("PORT", 5000))

    app.run(
        host="0.0.0.0",
        port=port,
        debug=False
    )
    
