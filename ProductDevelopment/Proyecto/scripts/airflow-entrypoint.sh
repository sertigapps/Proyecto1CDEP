#!/usr/bin/env bash
sudo apt-get install python3-mysql.connector
sudo apt-get install python-mysql.connector
airflow upgradedb
airflow webserver
pip install mysql-connector-python
pip3 install mysql-connector-python-rf