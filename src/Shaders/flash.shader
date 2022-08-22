shader_type spatial;
uniform sampler2D texture_albedo : hint_albedo;
uniform vec4 color: hint_color;
uniform float level:hint_range(0.0,1.0) = 0;


void fragment(){
	vec4 albedo_texture = texture(texture_albedo,UV);
	ALBEDO = mix(albedo_texture.rgb,color.rgb,level);
	ALPHA = albedo_texture.a;
}