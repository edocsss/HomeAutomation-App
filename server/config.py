import auth_config as AUTH_CONFIG


SERVER_PORT_NUMBER = 8888
MONGODB_URI = 'mongodb://{}:{}@ds133279.mlab.com:33279/home_automation_db'.format(AUTH_CONFIG.MONGODB_USERNAME, AUTH_CONFIG.MONGODB_PASSWORD)
DB_NAME = 'home_automation_db'
