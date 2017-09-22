settings = require './settings'
expect   = require('chai').expect

config =
  swu_api_key: ''
  path: 'templates'
  mjml_src: 'mjml'
  views_path: 'views/index'
  port: 3001

describe 'Swu_mjml',  ->
  it 'should be an Object', () ->
    Swu_mjml = require(process.cwd() + '/lib/swu_mjml')(config, settings)
    expect(Swu_mjml).to.be.an('object')
