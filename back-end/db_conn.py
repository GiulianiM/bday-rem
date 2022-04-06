import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate('bday--2022-firebase-adminsdk-l4t2c-b53207d211.json')
firebase_admin.initialize_app(cred)

link = firestore.client()

