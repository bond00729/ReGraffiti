import uvloop
import asyncio
import sqlite3
import json
import base64
import datetime
import aiohttp.web

asyncio.set_event_loop_policy(uvloop.EventLoopPolicy())

database = sqlite3.connect('regraffiti.db')
application = aiohttp.web.Application()

async def new_handler(request):
    cursor = database.cursor()

    cursor.execute('SELECT rowid, location, date FROM images ORDER BY date DESC LIMIT 10')

    return aiohttp.web.Response(text=json.dumps([
        {
            'id': result[0],
            'location': result[1],
            'date': result[2]
        } for result in cursor
    ]))

    database.commit()

async def create_image_handler(request):
    cursor = database.cursor()

    cursor.execute('INSERT INTO images VALUES (?, ?, ?)', (
        request.url.query['location'],
        str(datetime.datetime.now()),
        base64.b64decode(request.url.query['image'])
    ))

    return aiohttp.web.Response(text=str(cursor.lastrowid))

async def get_image_data_handler(request):
    cursor = database.cursor()

    cursor.execute('SELECT location, date FROM images WHERE rowid = ?', request.url.query['id'])
    result = cursor.fetchone()

    return aiohttp.web.Response(text=json.dumps({
        'location': result[0],
        'date': result[1]
    }))

async def get_image_handler(request):
    cursor = database.cursor()

    cursor.execute('SELECT image FROM images WHERE rowid = ?', request.url.query['id'])
    result = cursor.fetchone()

    return aiohttp.web.Response(body=result[0], content_type='image/jpeg')

application.router.add_route('GET', '/new_images', new_handler)
application.router.add_route('GET', '/create_image', create_image_handler)
application.router.add_route('GET', '/image_data', get_image_data_handler)
application.router.add_route('GET', '/image', get_image_handler)

aiohttp.web.run_app(application, port=8081)
