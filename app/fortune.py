import requests
import sys
import time
import random

r = requests.get('http://dojodevopschallenge.s3-website-eu-west-1.amazonaws.com/fortune_of_the_day.json')
if r.status_code == 200:
    j = r.json()
else:
    print("Problem when reading remote source. Response code: {}".format(r.response_code))
    sys.exit(1)
i = random.randint(0, len(j))
print(j[i]['message'])
