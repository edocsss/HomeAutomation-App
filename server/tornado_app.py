import tornado.ioloop as ioloop
import tornado.web as web

import config as CONFIG
from util.logger import web_logger as LOGGER
from handler.test_handler import TestHandler


if __name__ == '__main__':
    app = web.Application([
        (r"/test", TestHandler)
    ], debug=True)

    # Start server
    LOGGER.info("Starting server at port {}...".format(CONFIG.SERVER_PORT_NUMBER))
    app.listen(CONFIG.SERVER_PORT_NUMBER)
    ioloop.IOLoop.current().start()
