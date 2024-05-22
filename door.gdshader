shader_type canvas_item;
uniform bool opened;
void vertex() {
	
	if((sin((2.0*PI/10.0)*TIME) <0.0) && (opened))
	VERTEX.y += 70.0 * sin((2.0*PI/10.0)*TIME);
}
void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
