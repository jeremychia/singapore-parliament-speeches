# Base official python image
FROM python:3.10.13-slim-bookworm
## install requirements
COPY requirements.txt ./
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
## create directories
RUN mkdir -p /scripts
RUN mkdir -p /token
# get token
## copy files
COPY nltk_req.py .
RUN python nltk_req.py
RUN echo "$SECRET_TOKEN" > /token/gcp_token.json
COPY /scripts/extract /scripts/extract
COPY /scripts/load /scripts/load
COPY /scripts/resource-json /scripts/resource-json
COPY /scripts/seeds /scripts/seeds
COPY /scripts/transform /scripts/transform
COPY /scripts/utils /scripts/utils
COPY /scripts/main.py /scripts/main.py
## run the script
CMD python /scripts/main.py
