# FROM python:3.8.10-slim-buster
# FROM spark:3.5.1-python3

USER root
# RUN pip install --upgrade pip

# # RUN adduser --disabled-login app
# # USER app


# USER spark

WORKDIR /home/app


# SHELL ["/bin/bash", "-c"]
# RUN python -m venv env && source env/bin/activate
# RUN pip install --upgrade pip

# RUN python3 -m venv env

# COPY --chown=app:app requirements.txt requirements.txt
# RUN pip install --user -r requirements.txt

COPY --chown=spark:spark requirements.txt requirements.txt
RUN pip install --user -r requirements.txt

ENV PATH="/home/spark/.local/bin:${PATH}"
# ENV PATH="/home/app/.local/bin:${PATH}"

# COPY --chown=app:app . .