shader_type spatial;
//uniform float level: hint_range(0,1) = 0.0;
uniform vec4 LOAD_COLOR: hint_color;

void fragment(){
	float level = sin(TIME)+ 1.0; 
	vec4 local = inverse(WORLD_MATRIX) * CAMERA_MATRIX * vec4(VERTEX, 1.0);
	ALBEDO =  LOAD_COLOR.rgb;
	ALPHA = step(1.0 - level, 1.0 - local.y);
}
