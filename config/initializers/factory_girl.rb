if (Rails.env.development? || Rails.env.test?)
  ActionDispatch::Callbacks.after do
    unless FactoryGirl.factories.blank? # first init will load factories, this should only run on subsequent reloads
      FactoryGirl.factories.clear
      FactoryGirl.find_definitions
    end
  end
end
