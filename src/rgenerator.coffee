bodyParser = require 'body-parser'
express    = require 'express'
fs         = require 'fs'
router     = express.Router()

RGenerator  = (config, settings) ->
  @swu_api  = require('../lib/api/sendwithus')(config.swu_api_key)
  @builder  = require './builder'
  @config   = config
  @settings = settings

  router.use(bodyParser.json())

  @generate_html_paths()
  @list_templates()
  @update_template()
  @list_templates_from_swu()

RGenerator::list_templates = () ->
  builder    = @builder
  settings   = @settings
  views_path = @config['views_path']
  port       = @config['port']

  router.get '/', (req, res) ->
    data = builder.build_html_data settings
    res.render process.cwd() + '/' + views_path,
      shops: data,
      port: port

RGenerator::update_template = () ->
  builder    = @builder
  config  = @config
  swu_api = @swu_api
  router.post '/', (req, res) ->
    body      = req.body
    html_body = builder.get_html_path config, body.shop, body.template_name

    fs.readFile html_body, 'utf8', (err, data) ->
      return console.log(err) if err

      template_body = builder.build_template_body(body, data)
      swu_api.update_template template_body

RGenerator::list_templates_from_swu = () ->
  swu_api = @swu_api

  router.get '/swu-templates', (req, res) ->
    process_swu_templates (err, result) ->
      if err then console.log err else res.json result
    return

  process_swu_templates = (callback) -> swu_api.get_templates callback

RGenerator::generate_html_paths = () ->
  config = @config
  settings = @settings

  for shop, template of settings
    for template_name of template
      @build_paths config, shop, template_name

RGenerator::build_paths = (config, shop, template) ->
  builder = @builder
  console.info '\x1b[36m%s', '➲ Generating path:' + '\x1b[32m','GET /' + shop + '/' + template

  router.get ('/' + shop + '/' + template), (req, res) ->
    res.sendFile builder.get_html_path config, shop, template

module.exports = (config, settings) ->
  new RGenerator(config, settings)
  module.exports = router
