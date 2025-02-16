extends Node

var server = null
var clients = []

# Start the server when the game starts
func _ready():
	server = NetfoxServer.new()
	server.listen(12345)  # Port 12345 for the server
	print("Server started on port 12345")

# Handle new client connection
func on_client_connect(client):
	clients.append(client)
	print("New client connected: ", client)

# Handle incoming messages from clients
func on_message_received(client, message):
	print("Received message: ", message)
	# Process game actions like player movements, attacks, etc.

# Send data to all clients (for syncing)
func broadcast(message):
	for client in clients:
		client.send(message)
