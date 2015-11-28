class Colors
  SELECTED = [255,255,255,255].freeze
  INACTIVE = [255,255,255,150].freeze
end

define_stage :intro do
  curtain_up do
    create_actor :splash_screen
    create_actor :game_title

    start_label = create_actor :positioned_label,
                               text: "Start", font_name: "GameBoy.ttf", x: 0, y: 340, width: viewport.width, color: Colors::SELECTED
    exit_label = create_actor :positioned_label,
                              text: "Exit", font_name: "GameBoy.ttf", x: 0, y: 380, width: viewport.width, color: Colors::INACTIVE

    active_label = :start_label

    input_manager.reg :down, KbDown do
      exit_label.color = Colors::SELECTED
      start_label.color = Colors::INACTIVE
      active_label = :exit_label
    end

    input_manager.reg :down, KbUp do
      exit_label.color = Colors::INACTIVE
      start_label.color = Colors::SELECTED
      active_label = :start_label
    end

    input_manager.reg :down, KbReturn do
      case active_label
      when :start_label
        fire :next_stage
      when :exit_label
        input_manager.window.close
      end
    end
  end

  curtain_down do

  end

  helpers do

  end
end
