import datetime
import json

import pytz
import birthday
import user
import db_conn as db


class Handler:
    def __init__(self):
        self.users_list = []
        self.births_list = []
        self.tokens = []
        self.messages = []
        #self.fcm = {}
        self.today = datetime.date.today()

    # store all users in an array of User

    def populate_list_of_users(self):
        document = db.link.collection(u'users').stream()

        for i in document:
            self.users_list.append(
                user.User(i.to_dict()['uid'], i.to_dict()['token']))

    # store all birthdays in an array of Birthday

    def populate_list_of_births(self):
        for val in self.users_list:
            document = db.link.collection(u'birthdays').document(
                val.uid).collection(u'list').stream()

            for i in document:
                self.births_list.append(birthday.Birthday(i.to_dict()['name'], i.to_dict()['surname'], i.to_dict()[
                                        'birth'], i.to_dict()['docHash'], i.to_dict()['uid'], i.to_dict()['nickname']))

        # for i, val in enumerate(self.births_list):
        #     print (i, val.name, val.surname, val.uid)

    # populate a dict with the info about the person will born and
    # the user who stored the birth

    def store_births(self):
        for val in self.births_list:
            if is_birth(self.today, val):
                token = user_token(self.users_list, val.uid)
                message = birthday_message(self.today, val)
                #self.fcm.update({token: message})
                self.tokens.append(token)
                self.messages.append(message)

        # print(self.fcm)
        # print(self.tokens)
        # print(self.messages)

# check if today is the birthday
# (difference between the day&month of birthday and day&month of today, compared in same year)


def is_birth(today, val):
    birth = datetime.datetime.strptime(val.birth, "%b %d, %Y").date()
    birth = birth.replace(year=datetime.date.today().year)
    #print("today:", today ,"; database: ",birth," diff: ", (birth - today).days )
    return (birth - today).days == 0

# return the birth message to send to devices


def birthday_message(today, person):
    birth = datetime.datetime.strptime(person.birth, "%b %d, %Y").date()
    age = today.year - birth.year
    if person.nickname == "":
        return f"Oggi {person.surname} {person.name} compie {age} anni!"
    else:
        return f"Oggi {person.nickname} compie {age} anni!"


# return the token of user
def user_token(u_list, uid):
    for val in u_list:
        if val.uid == uid:
            return val.token
