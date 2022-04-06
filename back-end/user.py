class User:
    def __init__(self, uid, token):
        self.uid = uid
        self.token = token

    def to_dict():
        return {
            "uid": self.uid,
            "token": self.token
        }
    
