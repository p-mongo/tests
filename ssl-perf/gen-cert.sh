#!/bin/sh


openssl req -x509 -newkey rsa:4096 -keyout priv.pem -out cert.pem -days 365 -nodes 
