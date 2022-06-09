FROM python:3.7

# RUN mkdir /app
WORKDIR /app
# ADD . /app/
COPY app/requirements.txt ./
RUN pip install -r requiremets.txt

COPY app /app
EXPOSE 5000
CMD ["python", "/app/main.py"]