import os
import httpx
from fastapi import FastAPI, HTTPException
import uvicorn
# from dotenv import load_dotenv

# Загружаем переменные окружения из .env
# load_dotenv()

# SUPABASE_URL = os.getenv("SUPABASE_URL")
# SUPABASE_API_KEY = os.getenv("SUPABASE_API_KEY")

# start:         uvicorn server:app --host 0.0.0.0 --port 8000

SUPABASE_URL = 'https://uqpmzeeszodaaklmvoxe.supabase.co'
SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxcG16ZWVzem9kYWFrbG12b3hlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNDQ4MDAsImV4cCI6MjA1NDkyMDgwMH0.kqD92ybsgKPXqD_v19aJNY8vTjS59qQyMXDl6Xa7kKU'

app = FastAPI()

@app.get("/pay/{order_id}")
async def mark_order_paid(order_id: str):
    """Обновляет статус заказа в Supabase"""
    supabase_url = f"{SUPABASE_URL}/rest/v1/orders?id=eq.{order_id}"
    headers = {
        "apikey": SUPABASE_ANON_KEY,
        "Authorization": f"Bearer {SUPABASE_ANON_KEY}",
        "Content-Type": "application/json"
    }
    data = {"paid": True}

    async with httpx.AsyncClient() as client:
        response = await client.patch(supabase_url, json=data, headers=headers)

    if response.status_code == 204:
        return {"status": "success", "message": f"Order {order_id} marked as paid"}
    else:
        raise HTTPException(status_code=response.status_code, detail=response.text)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)