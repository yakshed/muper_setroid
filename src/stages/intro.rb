define_stage :intro do
  curtain_up do
    create_actor :splash_screen
    create_actor :game_title

    create_actor :positioned_label, text: "Start", font_name: "GameBoy.ttf", x: 0, y: 340, width: viewport.width
    create_actor :positioned_label, text: "Exit", font_name: "GameBoy.ttf", x: 0, y: 380, width: viewport.width, color: [255, 255, 255, 150]

    input_manager.reg :down, KbSpace do
      fire :next_stage
    end
  end

  curtain_down do

  end

  helpers do

  end
end
