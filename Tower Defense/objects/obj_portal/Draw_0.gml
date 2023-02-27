
image_angle += 1
image_alpha = abs(sin(current_time/10000))
draw_self()
draw_text(x-32, y+32, string("ST: {0} WV: {1}", state, wave))
draw_text(x-32, y+48, string("{0} {1}", time_to_next_wave, wait_to_create))
draw_text(x-32, y+64, string(array_creating))