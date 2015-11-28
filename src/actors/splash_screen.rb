define_actor :splash_screen do
  has_behavior animate_once: {
                 image: "splash_screen",
                 frame_update_time: 120,
                 second_animation_in: 6_000
               }

  view do
    draw do |target, x_off, y_off, z|
      target.draw_image actor.image, 0, 0, 0
    end
  end
end
