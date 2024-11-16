shader_type canvas_item;

uniform vec4 col1: source_color;
uniform vec4 col2: source_color;
uniform int colour = 1;
uniform bool enabled = true;

void vertex() {
	if (enabled) {
		switch (colour) {
			case 1:
				COLOR.a = 0.5;
				COLOR = mix(COLOR, col1, 0.5);
				break;
			case 2:
				COLOR.a = 0.5;
				COLOR = mix(COLOR, col2, 0.5);
				break;
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
