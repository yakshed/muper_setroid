define_behavior :animate_once do
  requires :resource_manager, :director

  setup do
    @images = {}
    @frame_update_time = @opts[:frame_update_time]
    @frame_update_time ||= 60
    @frame_time = 0
    @second_frame_time = 0

    # all animated actors have to have an idle animation
    # data/graphics/ship/idle/1.png
    @frame_num = 0

    actor.has_attributes action: :idle,
                         animating: false,
                         second_animation_in: nil
    actor.has_attributes :image, :width, :height

    action_changed nil, actor.action

    director.when :update do |time|
      if (@second_frame_time += time) >= actor.second_animation_in
        actor.animating = true
      end

      if actor.animating
        @frame_time += time
        if @frame_time > @frame_update_time
          if next_frame == 0
            actor.animating = false
            @second_frame_time = 0
          end
          @frame_time = @frame_time-@frame_update_time
        end
        set_image
      end
    end

    reacts_with :remove
  end

  helpers do
    def remove
      director.unsubscribe_all self
    end

    def next_frame
      action_set = @images[actor.action]
      @frame_num = (@frame_num + 1) % action_set.size unless action_set.nil?
    end

    def action_changed(old_action, new_action)
      @images[new_action] ||= resource_manager.load_animation_set actor, new_action
      @frame_num = 0
      set_image
    end

    def set_image
      action_set = @images[actor.action]
      raise "unknown action set #{actor.action} for #{actor}" if action_set.nil?

      image = action_set[@frame_num]
      actor.image = image
      actor.width = image.width
      actor.height = image.height
    end
  end
end
