DATA_PATH = File.join(Gamebox.configuration.data_path)

define_stage :level1 do
  requires :input_manager, :sound_manager, :physics_manager

  curtain_up do
    physics_manager.configure
    physics_manager.gravity = vec2(0,1800)

    director.when :update do |time|
      physics_manager.update(time)
    end

    sound_manager.play_music :crateria

    @svg_doc = resource_manager.load_svg "level1"

    @score = create_actor :score, x: 10, y: 10, font: "GameBoy.ttf"

    create_actor :svg_actor, name: :background, svg_doc: @svg_doc

    create_actor :background, anchor: :top_left

    @samus = create_actor :samus, x: 130, y: 90
    @ship = create_actor :ship, x: 1700, y: 10

    input_manager.reg :down, KbLeft do
      @samus.react_to :moving_left
    end

    input_manager.reg :up, KbLeft do
      @samus.react_to :stop_movement
    end

    input_manager.reg :down, KbRight do
      @samus.react_to :moving_right, 10
    end

    input_manager.reg :up, KbRight do
      @samus.react_to :stop_movement
    end

    physics_manager.restart_physics

    viewport.stay_centered_on @samus, x_offset: 20, y_offset: 20
  end

  curtain_down do

  end

  helpers do

  end
end
