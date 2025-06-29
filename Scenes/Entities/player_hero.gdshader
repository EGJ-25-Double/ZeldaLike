shader_type canvas_item;

uniform vec4 color_ok  = vec4(0.0, 1.0, 0.0, 0.4);
uniform vec4 color_bad = vec4(1.0, 0.0, 0.0, 0.4);
uniform bool is_ok = true;

void fragment() {
    vec2 uv = UV * 2.0 - 1.0;            // center‑origin
    float d = length(uv);                // radial distance
    float alpha = smoothstep(1.0, 0.7, d); // soft edge
    vec4 col = is_ok ? color_ok : color_bad;
    COLOR = vec4(col.rgb, col.a * alpha);
}