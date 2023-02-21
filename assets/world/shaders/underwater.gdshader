shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float speed = 0.02;
uniform vec2 direction = vec2(0.0, -1.0);
uniform vec4 tint_color : source_color;
uniform float tint_factor = 4.0;
uniform sampler2D distortion_texture : filter_nearest, repeat_enable;

void fragment() {
	vec2 distorted_uv = SCREEN_UV + texture(distortion_texture, UV + (direction * TIME * speed)).r * 0.02;
	vec4 screen_color = texture(SCREEN_TEXTURE, distorted_uv);

	float brightness = (screen_color.r + screen_color.g + screen_color.b) / tint_factor;
	vec4 grayscale = vec4(screen_color.r + brightness, screen_color.g + brightness, screen_color.b + brightness, screen_color.a);

	COLOR = grayscale * tint_color;
}