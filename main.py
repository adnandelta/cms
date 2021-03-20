from flask import Flask, redirect, url_for, request, render_template


app = Flask(__name__, static_url_path='/static')


username = "asd"

def validate(email, password):
    return False


@app.route('/')
def index():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    creds = None
    if request.method == "POST":

        email = request.form['email']
        password = request.form['password']
        if validate(email, password):
            return url_for('dashboard', userobj=user)
        else:
            return render_template('login.html', creds=False)

    return render_template('login.html', creds=creds)

@app.route('/dashboard')
def dashboard(userobj):
    return render_template('dashboard.html', user=userobj)

if __name__ == "__main__":
    app.run(debug=True)