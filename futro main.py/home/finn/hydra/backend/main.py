from fastapi import FastAPI

app = FastAPI()

@app.post("/event")
async def event(data: dict):
    print("Event empfangen von Gerät:", data)
    return {"status": "ok"}
