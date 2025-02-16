# Server.gd
extends Node

var server = null
var connected_clients = []

func _ready():
    server = NetworkedMultiplayerENet.new()
    server.create_server(12345, 10)  # Port 12345, max 10 clients
    get_tree().network_peer = server
    print("Server started on port 12345")

func _on_peer_connected(id):
    print("Client connected: " + str(id))
    connected_clients.append(id)

func _on_peer_disconnected(id):
    print("Client disconnected: " + str(id))
    connected_clients.erase(id)

func _process(delta):
    for client_id in connected_clients:
        rpc_id(client_id, "_sync_player_data", get_player_data())

remote func _sync_player_data(data):
    print("Syncing player data to client")
