gulp       = require 'gulp'
mjml       = require 'gulp-mjml'
express    = require 'express'
app        = express()

Swu_mjml = (config, settings) ->
  @config = config
  @settings = settings
  @folder = []

  for shop of @settings
    @folder.push shop

  return

Swu_mjml::start = () ->
  console.info '➲ Initializing SWU_MJML \r\n'

  @generate_routes()
  @gulp_watch_paths()
  @gulp_compile()

Swu_mjml::generate_routes = () ->
  RGenerator = require('../lib/rgenerator')(@config, @settings)

  app.use('/', RGenerator)
  app.set('view engine', 'ejs')
  app.set('json spaces', 2)
  server = app.listen @config['port']

Swu_mjml::gulp_compile = (params = null) ->
  folder    = @folder
  mjml_src  = @config['mjml_src']
  dest_path = @config['path']

  gulp.task 'collectAll', ->
    folder.forEach (shop, index) ->
      return gulp.src(mjml_src + '/' + shop + '/*.mjml')
        .pipe(mjml())
        .pipe(gulp.dest(dest_path + '/' + shop))

    unless params && params.development == true
      console.info '\x1b[35m%s', '➲ MJML files were successfully compiled – ' + current_time()

  gulp.start 'collectAll'

Swu_mjml::gulp_watch_paths = () ->
  mjml_src = @config['mjml_src']

  @folder.forEach (shop) ->
    path = mjml_src + '/' + shop + '/*.mjml'
    console.info '\x1b[36m%s', '➲ ' + 'watching path:' + '\x1b[35m', path

    gulp.watch path, [ 'collectAll' ]

current_time = () ->
  date = new Date
  date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds()

module.exports = (config, settings) ->
  new Swu_mjml(config, settings)
