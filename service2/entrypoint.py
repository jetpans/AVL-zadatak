import requests
import sys
import os

SERVICE1_URL = os.getenv("SERVICE1_URL", "ERR")

assert SERVICE1_URL != "ERR"

message = requests.get(sys.stdin.readline()).text
data = ["md5", message]

print(requests.post(SERVICE1_URL, data="\n".join(data)).text)
