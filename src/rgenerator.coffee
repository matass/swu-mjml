fs       = require 'fs'
express  = require('express')
router   = express.Router()
path     = require 'path'

Builder  = require path.resolve __dirname, 'builder'

RGenerator = (CONFIG, settings) ->
  @index CONFIG, settings
  @generate_html_path CONFIG, settings
  console.info ''

RGenerator::index = (CONFIG, settings) ->
  router.get '/', (req, res) ->
    data = Builder.build_html_data settings
    res.render process.cwd() + '/' + CONFIG.views_path,
      shops: data,
      port: CONFIG.port

  router.post '/', (req, res) ->
    body = req.body

    html_template = Builder.get_html_path CONFIG, body.shop, body.template_name

    fs.readFile html_template, 'utf8', (err, data) ->
      return console.log(err) if err

      template_body = Builder.build_template_body(body, data)
      Sendwithus.update_template template_body

RGenerator::generate_html_path = (CONFIG, settings) ->
  for shop, template of settings.templates
    for template_name of template
      @_build_paths CONFIG, shop, template_name

RGenerator::_build_paths = (CONFIG, shop, template) ->
  #console.info '\x1b[36m%s', '➲ Generating paths:' + '\x1b[32m','GET /' + shop + '/' + template

  router.get ('/' + shop + '/' + template), (req, res) ->
    res.sendFile Builder.get_html_path CONFIG, shop, template

module.exports = (config, settings) ->
  new RGenerator(config, settings)
  module.exports = router
