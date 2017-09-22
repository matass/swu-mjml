gulp       = require 'gulp'
mjml       = require 'gulp-mjml'
merge      = require 'merge-stream'
express    = require 'express'
app        = express()

Swu_mjml = (CONFIG, settings) ->
  @_init CONFIG, settings
  @gulp_tasks CONFIG, settings

Swu_mjml::_init = (CONFIG, settings) ->
  console.info '➲ Initializing SWU_MJML \r\n'

  Sendwithus = require('../lib/api/sendwithus')(CONFIG.swu_api_key)
  RGenerator = require('../lib/rgenerator')(CONFIG, settings)

  app.use('/', RGenerator)
  app.set('view engine', 'ejs')
  server = app.listen CONFIG.port

Swu_mjml::gulp_tasks = (CONFIG, settings) ->
  shops  = []
  bundle = []

  for shop of settings.templates
    shops.push shop

  gulp.task 'collectAll', ->
    shops.forEach (shop, index) ->
      bundle[index] = gulp.src(CONFIG.mjml_src + '/' + shop + '/*.mjml')
        .pipe(mjml())
        .pipe(gulp.dest(CONFIG.path + '/' + shop))

  shops.forEach (shop) ->
    gulp.watch CONFIG.mjml_src + '/' + shop + '/*.mjml', [ 'collectAll', 'mjml' ]

  gulp.start 'collectAll'

  gulp.task 'mjml', ->
    merge bundle
    console.info '\x1b[35m%s', '➲ MJML files were successfully compiled'

module.exports = (config, settings) ->
  new Swu_mjml(config, settings)
