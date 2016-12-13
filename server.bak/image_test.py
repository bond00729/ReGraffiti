import sqlite3
import base64

database = sqlite3.connect('regraffiti.db')
cursor = database.cursor()

with open('1.jpg', 'rb') as image:
    cursor.execute('INSERT INTO images VALUES (?, ?, ?)', ('Seattle', '2016-12-13 02:57:04.992628', base64.b64encode(image.read())))

with open('2.jpg', 'rb') as image:
    cursor.execute('INSERT INTO images VALUES (?, ?, ?)', ('Los Angeles', '2016-12-03 02:57:04.992628', base64.b64encode(image.read())))

with open('3.jpg', 'rb') as image:
    cursor.execute('INSERT INTO images VALUES (?, ?, ?)', ('New York City', '2016-12-01 02:57:04.992628', base64.b64encode(image.read())))

database.commit()
database.close()
