import os
from dotenv import load_dotenv

class Config(object):
    SECRET_KEY = 'secret_key_ucemining'

    MAIL_SERVER = 'smtp.sendgrid.net'
    DEFAULT_FROM_EMAIL = os.environ.get('DEFAULT_FROM_EMAIL')
    MAIL_PORT = 587
    MAIL_USE_SSL = False
    MAIL_USE_TLS = True
    MAIL_USERNAME = 'apikey'
    MAIL_PASSWORD = os.environ.get('MAIL_PASSWORD')

class DevelopmentConfig(Config):
    DEBUG = True
    SQLALCHEMY_DATABASE_URI = ("mysql+pymysql://u8afqm51hf1iuji6:JMorwFcnW4fYwjp5PLQx@localhost:3306/ucemining")
    SQLALCHEMY_TRACK_MODIFICATIONS = False
