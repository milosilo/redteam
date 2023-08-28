# Red Team Collection
Collection of various Red Teaming and Penetration Tools

**Curent Items**

- **C2 Library** - Libraryy of various C2 Server and Client scripts that go with a guide I wrote.  https://milosilo.com/hacking/command-and-controlc2-systems-with-examples/
-- There is a readme for operations below and in the folder.



# Command and Control (C2) System
https://milosilo.com/hacking/command-and-controlc2-systems-with-examples/
## Overview
This repository contains a simplified Command and Control (C2) system implemented in Python. The C2 server controls a client, allowing for various operations like file transfer, remote script execution, and general command execution.

## Features

### Server Side
- Listens for incoming connections from clients.
- Sends commands to the connected client.
- Receives output or files from the client based on the command issued.

### Client Side
- Connects to the C2 server.
- Waits for commands from the server.
- Executes the received command and sends back the output or files.

## Setup

### Requirements
- Python 3.x
- `pycrypto` library for AES encryption

### Installation
1. Clone this repository.
2. Install the requirements using `pip install -r requirements.txt`.

## Usage

### Starting the Server
Run `python C2_server_control.py` to start the server. The server will listen on port 8080 by default.

### Starting the Client
Run `python C2_client_control.py` to start the client. The client will attempt to connect to `localhost:8080` by default.

## Commands
- `upload:<filename>`: Uploads a file from the client to the server.
- `runscript:<scriptname>`: Executes a script on the client and sends back the output.
- General commands: Any other command will be executed on the client, and the output will be sent back.

## Disclaimer
This code is for educational purposes only. Do not use it for illegal activities.
