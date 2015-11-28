define_actor :game_title do
  has_behavior animate_once: {
                 image: "game_title",
                 frame_update_time: 120,
                 second_animation_in: 8_000
               }

  view do
    draw do |target, x_off, y_off, z|
      target.draw_image actor.image, 0, 0, 0
    end
  end
end
