from pymongo import *

from util.logger import web_logger as LOGGER
import config as CONFIG


class BaseDb():
    def __init__(self):
        LOGGER.info('Connecting to MongoDB...')
        try:
            self._client = MongoClient(CONFIG.MONGODB_URI)
            self._db = self._client[CONFIG.DB_NAME]
            LOGGER.info('Connected to MongoDB!')

        except Exception as e:
            LOGGER.error('Connection to MongoDB failed!')
            LOGGER.error(e)
            LOGGER.error('\n\n')