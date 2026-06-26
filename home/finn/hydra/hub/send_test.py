import requests

data = {
    "device": "NRF24-Gateway-01",
    "type": "test",
    "value": 123
}

requests.post("http://192.168.178.89:8000/event", json=data)
