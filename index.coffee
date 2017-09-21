settings = require './settings'

config =
  swu_api_key: 'YOU_API_KEY'
  path: 'templates'
  mjml_src: 'mjml'
  views_path: 'views/index'
  api_path: 'api'
  port: 3001

require('./lib/swu_mjml')(config, settings)
