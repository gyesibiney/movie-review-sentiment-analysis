#from fastapi import FastAPI, HTTPException, Query
#import pandas as pd
from fastapi import FastAPI
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModelForSequenceClassification, pipeline

app = FastAPI()

# Load the pre-trained model and tokenizer
model_name = "gyesibiney/Sentiment-review-analysis-roberta-3"
model = AutoModelForSequenceClassification.from_pretrained(model_name)
tokenizer = AutoTokenizer.from_pretrained(model_name)

# Create a sentiment analysis pipeline
sentiment = pipeline("sentiment-analysis", model=model, tokenizer=tokenizer)

# Define a request body model
class SentimentRequest(BaseModel):
    text: str

# Define a response model
class SentimentResponse(BaseModel):
    sentiment: str
    score: float

# Create an endpoint for sentiment analysis
@app.post("/sentiment/")
async def analyze_sentiment(request: SentimentRequest):
    input_text = request.text
    result = sentiment(input_text)
    sentiment_label = result[0]["label"]
    sentiment_score = result[0]["score"]

    if sentiment_label == "LABEL_1":
        sentiment_label = "positive"
    elif sentiment_label == "LABEL_0":
        sentiment_label = "neutral"
    else:
        sentiment_label = "negative"

    return SentimentResponse(sentiment=sentiment_label.capitalize(), score=sentiment_score)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
