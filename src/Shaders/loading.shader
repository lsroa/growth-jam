shader_type spatial;
uniform float level: hint_range(-1,1) = -1.0;
uniform vec4 LOAD_COLOR: hint_color;

void fragment(){
	vec4 local = inverse(WORLD_MATRIX) * CAMERA_MATRIX * vec4(VERTEX, 1.0);
	ALBEDO =  mix(ALBEDO, LOAD_COLOR.rgb, step(1.0 - level, 1.0 - local.y));
}
