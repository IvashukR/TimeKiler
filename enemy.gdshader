shader_type canvas_item;
uniform vec4 color_1:source_color;
uniform float value: hint_range(0.0, 1.0, 0.1);
void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, color_1, value );
	if(COLOR.rgb == vec3(1.0, 1.0, 1.0)){
		discard;
	}else{
		COLOR = color;
	}
}

