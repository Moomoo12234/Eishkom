shader_type canvas_item;

uniform vec4 tint_colour: source_color;
uniform bool tint;

void fragment() {
	if (tint) {
		vec4 greyscale = mix(COLOR, tint_colour, 0.5);
		if (COLOR.a != 0.0) {
			COLOR = greyscale;
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
