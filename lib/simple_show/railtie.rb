module SimpleShow
  class Railtie < Rails::Railtie
    initializer "simple_show.setup" do
      config.to_prepare do
        ApplicationController.helper(::SimpleShow::ApplicationHelper)
      end
    end
  end
end
