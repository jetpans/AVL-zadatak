# Changed python version to the one we know the project is stable on.
FROM python:3.12

RUN curl -sL https://github.com/openfaas/faas/releases/download/0.9.14/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

ENV fprocess="python2 entrypoint.py"
COPY entrypoint.py /

# Made generic pip install
RUN pip install -r requirements.txt
EXPOSE 8080
CMD [ "fwatchdog" ]