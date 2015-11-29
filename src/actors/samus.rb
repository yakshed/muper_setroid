define_actor :samus do
  has_behavior animated: { frame_update_time: 120, image: "samus" }
  has_behavior physical: {
                 shape: :poly,
                 moment: Float::INFINITY,
                 shapes: [
                   samus_suit: {
                     verts: [[0,0],[0,96],[50,96],[50,0]],
                     shape: :poly,
                     offset: vec2(0,6)
                   }
                 ],
                 mass: 150,
                 friction: 0.4,
                 verts: [[0,0],[0,96],[50,96],[50,0]]
               }
  has_behavior layered: { layer: 2, parallax: 1 }
  # has_behavior collidable: { shape: :circle, radius: 20 }

  behavior do
    requires :director

    setup do
      @speed     = actor.body.mass * 0.4
      @left_vec  = vec2(-@speed,0)
      @right_vec = vec2(@speed,0)
      @max_speed = 100

      reacts_with :moving_left, :moving_right

      director.when :update do |time|
        move_left(time) if moving_left?
        move_right(time) if moving_right?
      end
    end

    helpers do
      def moving_left?
        @moving == :left
      end

      def moving_right?
        @moving == :right
      end

      def move_left(time)
        @facing_dir = :left
        force = @left_vec*2
        actor.body.apply_impulse(force*time, CP::ZERO_VEC_2) if actor.body.v.length < @max_speed
      end

      def move_right(time)
        @facing_dir = :right
        force = @right_vec*2
        actor.body.apply_impulse(force*time, CP::ZERO_VEC_2) if actor.body.v.length < @max_speed
      end

      def moving_right(dist)
        @moving = :right
        actor.action = :move_right
      end

      def moving_left
        @moving = :left
        actor.action = :move_left
      end

      def stop
        @moving = false
        actor.action = :idle
      end
    end
  end

  view do
    draw do |target, x_off, y_off, z|
      x = actor.x + x_off
      y = actor.y + y_off
      target.draw_image actor.image, x, y, 2
    end
  end
end
