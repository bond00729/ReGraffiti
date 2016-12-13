import base64
import urllib.parse

with open('2.jpg', 'rb') as image:
    print(urllib.parse.quote_plus(base64.b64encode(image.read())))
