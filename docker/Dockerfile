FROM spark:3.5.1-python3

USER root
# RUN pip install --upgrade pip

# RUN adduser --disabled-login app
# USER app


# USER spark

WORKDIR /home/app

COPY requirements.txt requirements.txt
# COPY --chown=app:app requirements.txt requirements.txt
RUN pip install --user -r requirements.txt

# ENV PATH="/home/app/.local/bin:${PATH}"

