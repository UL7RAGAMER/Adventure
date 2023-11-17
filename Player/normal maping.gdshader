shader_type canvas_item;
uniform sampler2D normal_map : hint_default_black;
void fragment() {

	NORMAL_MAP = texture(NORMAL_TEXTURE,UV).rgb;
	// Place fragment code here.
}
