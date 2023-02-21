shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// uniform vec4 tint_color : source_color;

uniform float wave_speed = 3.0; //wave loop speed
uniform float wave_freq = 10.0; //wave vertical freq
uniform float wave_width = 1; //wave width 

void fragment() {
	vec2 wave_uv_offset = vec2(0, 0);
	wave_uv_offset.x = cos((TIME * wave_speed) + UV.x + UV.y * wave_freq * 2.0) * wave_width * 0.01;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + wave_uv_offset);
}