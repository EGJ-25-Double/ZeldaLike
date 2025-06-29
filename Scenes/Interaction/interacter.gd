class_name Interacter
extends Node

var timer: float = 0

func _process(delta: float) -> void:
	if timer >= 0:
		timer = timer - delta
	
	if InventoryUtils.is_inventory_open || timer > 0: return
	if Input.is_action_just_pressed("action_a"):
		timer = .5
		InventoryUtils.use_item_a()
		if (PlayerHero.instance != null && InventoryUtils.item_a != null):
			PlayerHero.instance.start_interact_anim()
	elif Input.is_action_just_pressed("action_b"):
		timer = .5
		InventoryUtils.use_item_b()
		if (PlayerHero.instance != null && InventoryUtils.item_b != null):
			PlayerHero.instance.start_interact_anim()
