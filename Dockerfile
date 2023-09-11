FROM python:3.9

# Set the working directory
WORKDIR /code

# Copy the requirements file
COPY ./requirements.txt /code/requirements.txt

# Copy the file or directory into the image (adjust the path as needed)
COPY ./gyesibiney/Sentiment-review-analysis-roberta-3 /code/gyesibiney/Sentiment-review-analysis-roberta-3

# Install requirements
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Expose the port the FastAPI app will run on
EXPOSE 7860

# The CMD instruction specifies the command to run when the container starts
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]