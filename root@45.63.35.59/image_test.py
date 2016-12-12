import sqlite3
import base64

database = sqlite3.connect('regraffiti.db')
cursor = database.cursor()

with open('t3_56vbsm.jpeg', 'rb') as image:
    cursor.execute('INSERT INTO images VALUES (?, ?, ?)', ('asdf', 'asdf', base64.b64encode(image.read())))

database.commit()
database.close()
