define_actor :ship do
  has_behavior animated: { frame_update_time: 120, image: "ship" }
  has_behavior physical: {
                 shape: :poly,
                 fixed: true,
                 moment: Float::INFINITY,
                 shapes: [
                   samus_suit: {
                     verts: [[0,0],[0,220],[470,220],[470,0]],
                     shape: :poly
                   }
                 ],
                 mass: 150,
                 friction: 0.4,
                 verts: [[0,0],[0,220],[470,220],[470,0]]
               }
  has_behavior layered: { layer: 2, parallax: 1 }

  view do
    draw do |target, x_off, y_off, z|
      x = actor.x + x_off
      y = actor.y + y_off
      target.draw_image actor.image, x, y, 2
    end
  end
end
