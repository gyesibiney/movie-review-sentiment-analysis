# Use a base image
FROM python:3.8

# Set the working directory
WORKDIR /code

# Copy the requirements file
COPY ./requirements.txt /code/requirements.txt

# Install requirements
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Install transformers library
RUN pip install transformers

# Specify the model name from Hugging Face
ARG MODEL_NAME="gyesibiney/Sentiment-review-analysis-roberta-3"

# Download the model from Hugging Face (you can replace 'main' with a specific tag or version)
RUN transformers-cli login

# Clone the model repository
RUN transformers-cli repo clone git lfs install
git clone gyesibiney/Sentiment-review-analysis-roberta-3 --path /code/model

# Add your application code here to use the downloaded model

# Example: Run your FastAPI application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
