import sqlite3

database = sqlite3.connect('regraffiti.db')
cursor = database.cursor()

cursor.execute('CREATE TABLE images (location text, date text, image blob)')

database.commit()
database.close()
