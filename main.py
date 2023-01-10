import json

from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
import json
import math
import os
from flask_mail import Mail
from datetime import datetime

from werkzeug.utils import secure_filename

# to config json module

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER'] = params['upload_location']
# flask email
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-pass']
)
mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params[
        "local_uri"]  # used to connet data base. here we used URI for mysql database
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)  # initialization here SQLAlchemy() i did instead of SQLAlchemy(app)


class Contacts(db.Model):
    '''
    sno, name, phone_num, msg, date, email
    '''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=False, nullable=False)
    phone_num = db.Column(db.String(12), unique=False, nullable=False)
    msg = db.Column(db.String(120), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)
    email = db.Column(db.String(20), unique=False, nullable=False)


class Posts(db.Model):
    '''
    sno, name, phone_num, msg, date, email
    '''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), unique=False, nullable=False)
    slug = db.Column(db.String(21), unique=False, nullable=False)
    content = db.Column(db.String(120), unique=False, nullable=False)
    tagline = db.Column(db.String(120), unique=False, nullable=False)
    date = db.Column(db.String(12), unique=False, nullable=True)
    img_file = db.Column(db.String(12), unique=False, nullable=False)


@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts) / int(params['no_of_posts']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):  # is it digit cheking
        page = 1
    page = int(page)
    j = (page - 1) * int(params['no_of_posts']) #post sclicing
    posts = posts[j:j + int(params['no_of_posts'])] # assign unique post for every new page
    # pagination logiv
    # first
    # previous = blank
    # next = page+1
    if page == 1:
        prev = "#"
        next = "/?page=" + str(page + 1)

        # last
        # prev = page -1
        # next = blank
    elif page == last:
        prev = "/?page=" + str(page - 1)
        next = "#"

    else:
        next = "/?page=" + str(page + 1)
        prev = "/?page=" + str(page - 1)

    # middle
    # prev = page-1
    # next = page +1

    # it will first 5 post
    # if database dont have 5 post. then it might give error
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


# dashboard / login
@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    # if user already login
    if ('user' in session and session['user'] == params["admin_user"]):
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if (username == params["admin_user"] and userpass == params["admin_password"]):
            # Set the session variable
            session['user'] = username  # yt solultion
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    else:
        return render_template('login.html', params=params)


@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if request.method == 'POST':
        box_title = request.form.get('title')
        tline = request.form.get('tline')
        slug = request.form.get('slug')
        content = request.form.get('content')
        img_file = request.form.get('img_file')
        date = datetime.now()

        if sno == '0':
            post = Posts(title=box_title, slug=slug, content=content, tagline=tline, img_file=img_file, date=date)
            db.session.add(post)
            db.session.commit()
        else:
            post = Posts.query.filter_by(sno=sno).first()
            post.title = box_title
            post.slug = slug
            post.content = content
            post.tagline = tline
            post.img_file = img_file
            post.date = date
            db.session.commit()
            return redirect('/edit/' + sno)
    post = Posts.query.filter_by(sno=sno).first()
    return render_template('edit.html', params=params, post=post, sno=sno)


@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
        return "Uploaded successfully"


@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect("/dashboard")


@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if "user" in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect("/dashboard")


@app.route('/contact', methods=['GET', 'POST'])
def contact():
    if (request.method == 'POST'):
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        message = request.form.get("message")
        ''' add entry to database
                 sno, name, phone_num, msg, date, email
                 '''
        entry = Contacts(name=name, phone_num=phone, msg=message, date=datetime.now(), email=email)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('new message from ' + name,
                          sender=email,
                          recipients=[params['gmail-user']],
                          body=message + "\n" + phone + "\n" + email
                          )

    return render_template('contact.html', params=params)


@app.route("/post/<string:post_slug>", methods=['GET'])
def post(post_slug):  # this is flask variable should be plced.this is syntax
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)


@app.route('/index')
def index():
    return render_template('index.html', params=params)


app.run(debug=True)
