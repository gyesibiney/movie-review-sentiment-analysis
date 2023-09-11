# Use a base image
FROM python:3.8

# Set the working directory
WORKDIR /code

# Copy the requirements file
COPY ./requirements.txt /code/requirements.txt

# Install requirements
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Add your application code here (e.g., FastAPI code)
COPY main.py .
# Install transformers library
RUN pip install transformers

# Specify the model name from Hugging Face
ARG MODEL_NAME="gyesibiney/covid-tweet-sentimental-Analysis-roberta"

# Download the model from Hugging Face (you can replace 'main' with a specific tag or version)
RUN transformers-cli login --api-key your_api_key_here
RUN transformers-cli repo clone $MODEL_NAME --path /code/model

# Add your application code here to use the downloaded model

# Example: Run your FastAPI application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
