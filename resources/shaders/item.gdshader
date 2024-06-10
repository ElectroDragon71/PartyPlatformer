shader_type canvas_item;

uniform bool PREVIEW = false;
uniform bool PLACEABLE = true;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 white_color = vec4(1.0, 1.0, 1.0, previous_color.a);
	vec4 new_color = previous_color;
	
	if(PREVIEW == true){
		if(PLACEABLE == false){
			new_color.r = 0.4;
			new_color.g = new_color.g / 1.5;
			new_color.b = new_color.b / 1.5;
		}else{
			new_color = previous_color;
		}
		if(new_color.a == 1.0){
			new_color.a = 0.5;
		}
	}else{
		new_color = previous_color;
	}
	
	COLOR = new_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
