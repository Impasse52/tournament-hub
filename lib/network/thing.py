import requests
from pprint import pprint

url = "https://api.smash.gg/gql/alpha"

output = []
for i in range(0, 10):
    payload = "{\"query\":\"query Videogames{\\n\\tvideogame (id: " + str(i) + ") {\\n\\t\\tname\\n\\t\\tid\\n\\t\\tdisplayName\\n\\t\\tslug\\n\\t}\\n}\",\"operationName\":\"Videogames\"}"
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer 8ffbe506e66d64b7b562d0fab413c035"
    }

    response = requests.request("POST", url, data=payload, headers=headers)

    output.append(response.text)

pprint(output)