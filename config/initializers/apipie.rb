Apipie.configure do |config|
  config.app_name = 'Enapparte'
  config.api_base_url = '/api'
  config.doc_base_url = '/apidoc'
  config.reload_controllers = Rails.env.development?
  config.api_controllers_matcher = File.join(Rails.root, 'app', 'controllers',
                                             'api', '**', '**')
  config.api_routes = Rails.application.routes
  config.default_version = 'V1'
  config.validate = true
  config.default_locale = 'en'
  config.markup = Apipie::Markup::Markdown.new
  config.validate = false
end
