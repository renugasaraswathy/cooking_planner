# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
 Rails.application.config.assets.precompile += %w( login.css )
 Rails.application.config.assets.precompile += %w( main.css )
 Rails.application.config.assets.precompile += %w( jquery-ui.min.css )
 Rails.application.config.assets.precompile += %w( zabuto_calendar.min.css )
 Rails.application.config.assets.precompile << "tinymce-jquery.js" 
 Rails.application.config.assets.precompile += %w( tinymce/plugins/uploadimage/plugin.js tinymce/plugins/uploadimage/langs/en.js )