shader_type canvas_item;
uniform float alpha: hint_range(0.0,1.0,0.1) = 0;
uniform vec3 col: source_color = vec3(1);
uniform sampler2D nm;
void fragment() {
	float cur_a = texture(TEXTURE,UV).a;
	vec4 t_c = mix(texture(TEXTURE,UV),vec4(vec3(col), cur_a),alpha);
	COLOR = t_c;
	}
	
	
