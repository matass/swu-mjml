chai      = require 'chai'
expect    = chai.expect
chaiFiles = require 'chai-files'
file      = chaiFiles.file
chai.use chaiFiles

templates =
  example1:              # folder name
    racoon1:             # template name
      id: 'tem_xxx'
      version: 'ver_xxx'
    racoon2:
      id: 'tem_xxx'
      version: 'ver_xxx'
  example2:
    racoon1:
      id: 'tem_xxx'
      version: 'ver_xxx'

config = {
  swu_api_key: 'test_xxx',
  path: 'test/templates',
  mjml_src: 'test/mjml',
  views_path: 'test/views/index',
  port: 3001
}

Swu_mjml = require(process.cwd() + '/lib/swu_mjml')(config, templates)
Builder  = require(process.cwd() + '/lib/builder')

html_data = Builder.build_html_data(templates)
settings_size = Object.keys(templates).length

test_html_dir = (expectation) ->
  for index, shop of html_data
    for template in shop['data']
      file_name = Builder.get_html_path config, shop['name'], template['name']

      expect(file(file_name)).to.not.exist if expectation == 'empty'
      expect(file(file_name)).to.exist if expectation == 'compiled'

describe 'Before initializing swu-mjml', ->
  it config['path'] + 'Should be empty', () ->
    test_html_dir 'empty'

describe 'Initializing gulp_tasks', ->
  it 'Should return no errors', () ->

Swu_mjml.gulp_compile(development: true)

describe config['path'], ->
  it 'Should be compiled', ->
    setTimeout (-> test_html_dir('compiled') ), 0
