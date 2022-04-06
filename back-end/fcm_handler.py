from firebase_admin import messaging
import requests
from requests.structures import CaseInsensitiveDict

class Fcm:

    def __init__(self, to_dict=None):
        if to_dict is not None:
            self.to_dict = to_dict
        else:
            self.to_dict =  None

    # def send_to_token(self):
    #     # This registration token comes from the client FCM SDKs.
    #     # registration_token = 'dxyOl23WTFGxu-hWdME1qG:APA91bE08nnfBckhWUCjwI7OYmPBFY4izzJYODSopk6XZoaEOBtFQPllJ9qD7aoXKzDy_-Sx4lcsBHZ3AhdqJ1rt2rDM3ZHs9p8j0GWyIZnamV6Hb4AfMiGwRLO8-f5F0urjiMs-IPRQ'
    #     registration_token = "fuKJVXfuQJCizI4E_F8bCD:APA91bEW2q94NVX8g-uHPQD8h24ngf65f_RhyLDJhjP_VusABLpk92JB8o2wm-hKmDXAtEX24GZgZKWqrCE51GUHaQQKIvEPlTwGauGyYhPoj3AvcWSb0jbeLk3crFIpafij9G6rqFnn"        # See documentation on defining a message payload.
    #     message = messaging.Message(
    #         data={
    #             'score': '850',
    #             'time': '2:45',
    #         },
    #         token=registration_token,
    #     )

    #     # Send a message to the device corresponding to the provided
    #     # registration token.
    #     response = messaging.send(message)
    #     # Response is a message ID string.
    #     print('Successfully sent message:', response)


    def send_to_token(self, tokens, messages):
        url = "https://fcm.googleapis.com/fcm/send"

        headers = CaseInsensitiveDict()
        headers["Accept"] = "application/json"
        headers["Authorization"] = "Bearer AAAALJM7h1A:APA91bExioRy8d_L20m72gSvGG-FobqZXSFznnGKN6DYZtoLF3-WICYqaKZsX_n_kF9uITHkqZP_ihrfGJ3Zoi-TxgO4iIv8oBvnbm3lDtrtGDa-yxpac2OQ2u7tiuP6EBCMGS_eh7pc"
        headers["Content-Type"] = "application/json"

        for i,val in enumerate(tokens):
            # print (f"key: {key}")
            # print (f"val: {to_dict[key]}")

            data = """
            {
                "to":"%s"
                "notification":{
                    "body":"%s"
                    "title":"Buon Compleanno!"
                }
            
            }
            """ % (val, messages[i])

            resp = requests.post(url, headers=headers, data=data)
            print(resp.status_code)
