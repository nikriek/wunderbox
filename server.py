from flask import Flask, render_template
from hamlish_jinja import HamlishTagExtension
from dropbox.client import DropboxClient, DropboxOAuth2Flow

app = Flask(__name__)
app.jinja_env.add_extension(HamlishTagExtension)
app.debug = True

DROPBOX_APP_KEY = 'hfkiz1qfjr1g065'
DROPBOX_APP_SECRET = 'slyp0g8o3ptcq0s'

@app.route("/")
def hello():
    return render_template('index.html.haml')

if __name__ == "__main__":
    app.run()