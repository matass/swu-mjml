gulp       = require 'gulp'
mjml       = require 'gulp-mjml'
merge      = require 'merge-stream'
express    = require 'express'
app        = express()

Swu_mjml = (CONFIG, settings) ->
  @init CONFIG, settings
  @gulp_tasks CONFIG, settings

Swu_mjml::init = (CONFIG, settings) ->
  console.info '➲ Initializing SWU_MJML \r\n'

  RGenerator = require('../lib/rgenerator')(CONFIG, settings)

  app.use('/', RGenerator)
  app.set('view engine', 'ejs')
  server = app.listen CONFIG.port

Swu_mjml::gulp_tasks = (CONFIG, settings) ->
  shops  = []
  bundle = []

  for shop of settings
    shops.push shop

  console.info '\x1b[36m%s', '➲ Directories:' +  '\x1b[35m', shops
  console.info ''

  shops.forEach (shop) ->
    path = CONFIG.mjml_src + '/' + shop + '/*.mjml'
    console.info '\x1b[36m%s', '➲ ' + 'watching path:' + '\x1b[35m', path

    gulp.watch path, [ 'collectAll', 'mjml' ]

  console.info ''

  gulp.task 'collectAll', ->
    shops.forEach (shop, index) ->
      bundle[index] = gulp.src(CONFIG.mjml_src + '/' + shop + '/*.mjml')
        .pipe(mjml())
        .pipe(gulp.dest(CONFIG.path + '/' + shop))

  gulp.start 'collectAll'

  gulp.task 'mjml', ->
    merge bundle
    console.info '\x1b[35m%s', '➲ MJML files were successfully compiled'

module.exports = (config, settings) ->
  new Swu_mjml(config, settings)
