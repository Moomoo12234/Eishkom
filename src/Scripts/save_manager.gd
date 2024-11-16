extends Node

@export_file("*.txt") var filePath

func saveData(data: String) -> void:
	var file = FileAccess.open(filePath, FileAccess.WRITE)
	file.store_string(data)

func loadData() -> String:
	var file = FileAccess.open(filePath, FileAccess.READ)
	return file.get_as_text()
