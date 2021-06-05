class Config(object):
    SECRET_KEY = 'secret_key_ucemining'

    MAIL_SERVER = 'smtp.gmail.com'
    MAIL_PORT = 587
    MAIL_USE_SSL = False
    MAIL_USE_TLS = True
    MAIL_USERNAME = 'ucemining.app@gmail.com'
    MAIL_PASSWORD = 'ucemining0.1'

class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = ("mysql+pymysql://bn1ja:0912@localhost:3306/ucemining")
    SQLALCHEMY_TRACK_MODIFICATIONS = False