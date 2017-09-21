gulp       = require 'gulp'
mjml       = require 'gulp-mjml'
merge      = require 'merge-stream'
express    = require 'express'
app        = express()

Swu_mjml = (CONFIG, settings) ->

  @_init CONFIG, settings
  @gulp_tasks CONFIG, settings
  return

Swu_mjml::_init = (CONFIG, settings) ->
  Sendwithus = require('../src/api/sendwithus')(CONFIG.swu_api_key)
  RGenerator = require('../src/rgenerator')(CONFIG, settings)

  app.use('/' + CONFIG.path, RGenerator)
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
      return
    return

  shops.forEach (shop) ->
    gulp.watch CONFIG.mjml_src + '/' + shop + '/*.mjml', [ 'collectAll', 'mjml' ]
    return

  gulp.start 'collectAll'

  gulp.task 'mjml', ->
    merge bundle

module.exports = (config, settings) ->
  new Swu_mjml(config, settings)
