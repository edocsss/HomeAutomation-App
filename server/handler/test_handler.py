from handler.base_handler import BaseHandler
from tornado.escape import json_encode


class TestHandler(BaseHandler):
    def get(self):
        self.write(json_encode({
            'result': True
        }))