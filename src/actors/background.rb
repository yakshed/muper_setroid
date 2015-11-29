define_actor :background do
  has_behavior :graphical
  has_behavior layered: { layer: 0, parallax: Float::INFINITY }
  # has_behavior physical: {
  #                mass: Float::INFINITY,
  #                friction: 0.7,
  #                shape: :poly,
  #                fixed: true,
  #                verts: [
  #                ]
  #              }
end
