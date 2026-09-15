FROM python:3.11

WORKDIR /app

COPY codebase /app/pytorch-lightning

RUN pip install --no-cache-dir "setuptools<82" wheel && \
    FREEZE_REQUIREMENTS=1 pip install --no-cache-dir --no-build-isolation \
    -e "/app/pytorch-lightning[app]" \
    "pytorch-lightning==2.2.1" "torch==2.1.2"

COPY app.py /app/app.py

ENV LIGHTNING_APP_STATE_URL=http://0.0.0.0

CMD ["python3", "-m", "lightning", "run", "app", "app.py"]
