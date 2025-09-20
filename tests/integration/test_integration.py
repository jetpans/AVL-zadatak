import requests
import pytest


SERVICE1_URL = "http://localhost:8080"
SERVICE2_URL = "http://localhost:8081"


def test_service1():
    response = requests.post(SERVICE1_URL, data="md5\n123")
    assert response.status_code == 200
    assert response.text == "202cb962ac59075b964b07152d234b70\n"  # MD5 of 123


def test_service2():
    url = "https://google.com"
    response = requests.post(SERVICE2_URL, data=url)
    assert response.status_code == 200
    assert len(response.text) == 34


def test_three():
    assert 3 == 3
