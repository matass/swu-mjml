gulp       = require 'gulp'
mjml       = require 'gulp-mjml'
express    = require 'express'
app        = express()

Swu_mjml = (config, settings) ->
  @config = config
  @settings = settings
  return

Swu_mjml::start = () ->
  console.info '➲ Initializing SWU_MJML \r\n'

  @generate_routes()
  @gulp_tasks()

Swu_mjml::generate_routes = () ->
  RGenerator = require('../lib/rgenerator')(@config, @settings)

  app.use('/', RGenerator)
  app.set('view engine', 'ejs')
  app.set('json spaces', 2)
  server = app.listen @config['port']

Swu_mjml::gulp_tasks = () ->
  mjml_src  = @config['mjml_src']
  dest_path = @config['path']
 
  shops  = []

  for shop of @settings
    shops.push shop

  shops.forEach (shop) ->
    path = mjml_src + '/' + shop + '/*.mjml'
    console.info '\x1b[36m%s', '➲ ' + 'watching path:' + '\x1b[35m', path

    gulp.watch path, [ 'collectAll' ]

  console.info ''

  gulp.task 'collectAll', ->
    shops.forEach (shop, index) ->
      gulp.src(mjml_src + '/' + shop + '/*.mjml')
        .pipe(mjml())
        .pipe(gulp.dest(dest_path + '/' + shop))
    console.info '\x1b[35m%s', '➲ MJML files were successfully compiled'

  gulp.start 'collectAll'

module.exports = (config, settings) ->
  new Swu_mjml(config, settings)
