class Birthday:

    def __init__(self, name, surname, birth, docHash, uid, nickname=None):
        self.name = name
        self.surname =surname
        self.birth = birth
        self.docHash = docHash
        self.uid = uid

        if nickname is not None:
            self.nickname = nickname
        else:
            self.nickname =  None