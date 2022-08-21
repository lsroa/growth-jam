shader_type spatial;
//uniform float level: hint_range(0,2) = 2.0;
uniform vec4 LOAD_COLOR: hint_color;

void fragment(){
	float level = sin(TIME) + 1.0; 
	vec4 local = inverse(WORLD_MATRIX) * CAMERA_MATRIX * vec4(VERTEX, 1.0);
	vec3 bottom_color = vec3(step(1.0 - level, - local.y)) * LOAD_COLOR.rgb;
	vec3 top_color = vec3(step(level - 1.0,  local.y));
	ALBEDO =  top_color + bottom_color;
}
