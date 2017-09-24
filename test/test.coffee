expect   = require('chai').expect
assert   = require('chai').assert

settings = 
  version_1: test:
    id: 'tem_xxx'
    version: 'ver_xxx'

  version_2: mobile_apps:
    id: 'tem_xxx'
    version: 'ver_xxx'

  version_3: mobile_apps:
    id: 'tem_xxx'
    version: 'ver_xxx'

config =
  swu_api_key: ''
  path: 'templates'
  mjml_src: 'mjml'
  views_path: 'views/index'
  port: 3001

Builder = require(process.cwd() + '/lib/builder')

describe 'Builder',  ->
  it 'should build array of 3 objects', () ->
    html_data = Builder.build_html_data(settings)
    assert.equal html_data.length, 3
