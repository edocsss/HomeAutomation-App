import base64
import hmac
import hashlib
import auth_config as AUTH_CONFIG


def basic_auth(handler_class):
    def wrap_execute(handler_execute):
        def require_auth(handler, kwargs):
            auth_header = handler.request.headers.get('Authorization')

            if auth_header is None or not auth_header.startswith('Basic '):
                handler.set_status(401)
                handler.set_header('WWW-Authenticate', 'Basic realm=You are not the home owner!')
                handler._transforms = []
                handler.finish()
                return False

            auth_decoded = base64.b64decode(auth_header[6:]).decode('utf-8')
            username, password = auth_decoded.split(':', 2)
            auth_status = _check_auth_credentials(username, password)

            if not auth_status:
                handler.set_status(401)
                handler.set_header('WWW-Authenticate', 'Basic realm=You are not the home owner!')
                handler._transforms = []
                handler.finish()
                return False

            return True


        def _execute(self, transforms, *args, **kwargs):
            if not require_auth(self, kwargs):
                return False

            return handler_execute(self, transforms, *args, **kwargs)

        return _execute

    handler_class._execute = wrap_execute(handler_class._execute)
    return handler_class


def _check_auth_credentials(username, password):
    hashed_check_password = hmac.new(
        bytes(AUTH_CONFIG.HASH_SECRET, 'utf-8'),
        bytes(password, 'utf-8'),
        digestmod=hashlib.sha512
    ).digest()

    if username != AUTH_CONFIG.USERNAME or hashed_check_password != AUTH_CONFIG.HASHED_PASSWORD:
        return False

    return True