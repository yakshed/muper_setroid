define_stage :intro do
  curtain_up do
    create_actor :splash_screen

    input_manager.reg :down, KbSpace do
      fire :next_stage
    end
  end

  curtain_down do

  end

  helpers do

  end
end
