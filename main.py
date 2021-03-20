from flask import Flask, redirect, url_for, request, render_template
from pymongo import MongoClient


app = Flask(__name__, static_url_path='/static')
#client = MongoClient('')
#db = client['cms']
db = None


def validate(email, password):
    user = db['users'].findOne({'email':email})

    if user is None:
        return False
    
    if user['password'] != password:
        return False
    
    return True


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == "POST":
        name = request.form['name']
        email = request.form['email']
        password = request.form['password']

        data = {
            "name":name,
            "email":email,
            "password":password,
            "section": 1,
            "professor": {
                "name":"Daniel",
                "email":"daniel@xyz.com"
            },
            "assignments": {
                "maths":False,
                "english":False,
                "physics":False
            },
            "exam": {
                "maths":0,
                "english":0,
                "physics":0
            }
            "attendance": {
                "maths":10,
                "english":10,
                "physics":10
            },
            "prof":False
        }

        db['users'].insertOne(data)
        return url_for('login')
    
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    creds = None
    if request.method == "POST":

        email = request.form['email']
        password = request.form['password']
        if validate(email, password):
            user = db['users'].findOne({'email':email})
            return url_for('dashboard', userobj=user)
        else:
            return render_template('login.html', creds=False)

    return render_template('login.html', creds=creds)

@app.route('/dashboard')
def dashboard(userobj=None):
    userobj = None
    return render_template('dashboard.html', user=userobj)

if __name__ == "__main__":
    app.run(debug=True)