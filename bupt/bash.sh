## slave
    python3 b4lcx.py slave -l localhost:8001 -r localhost:8000 -u admin:admin
# listen
python3 b4lcx.py listen -p 8000 -u admin:admin

#server
python3 server.py -b localhost:8002 -s s -l 8080
#client
python3 client.py -s c -b localhost:8080 -l 8081
