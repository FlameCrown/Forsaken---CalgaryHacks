extends Node2D


# Called when the "Host Server" button is clicked
func _on_host_pressed():
    var network = ENetMultiplayerPeer.new()
    
    var port = 1234  # Example port
    var max_clients = 10  # Max number of clients allowed
    var result = network.create_server(port, max_clients)
    
    if result == OK:
        
        print("Server created successfully!")
        # Transition to the game scene where server logic is handled
        get_tree().change_scene_to_file("res://StickyStone.tscn")
    else:
        print("Failed to create server")

# Called when the "Join Server" button is clicked
func _on_join_pressed():
    var ip = $LineEdit.text
    var network = ENetMultiplayerPeer.new()

    var result = network.create_client("localhost", 1234)  # Port should be the same as the server's
    if result == OK:
        
        print("Connected to server!")
        # Transition to the game scene
        get_tree().change_scene_to_file("res://StickyStone.tscn")
    else:
        print("Failed to connect to server")
