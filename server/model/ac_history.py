from model.base_model import BaseModel


class AcHistory(BaseModel):
    def __init__(self, date, time, status):
        self.date = date
        self.time = time
        self.status = status
        BaseModel.__init__(self)