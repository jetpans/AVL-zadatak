FROM ghcr.io/openfaas/of-watchdog:0.9.11 AS watchdog
# Changed from latest to version we know is stable
FROM python:3.12-slim

# Copy the watchdog binary from the official image
COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog


# Generic pip install
COPY requirements.txt /
RUN pip install -r requirements.txt 

ENV fprocess="python3 entrypoint.py"
COPY entrypoint.py /

EXPOSE 8080
CMD [ "fwatchdog" ]