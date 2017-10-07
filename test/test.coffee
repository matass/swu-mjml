chai      = require 'chai'
expect    = chai.expect
assert    = chai.assert
chaiFiles = require 'chai-files'
file      = chaiFiles.file
chai.use chaiFiles

settings =
  example1:
    racoon1:
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

require('../lib/swu_mjml')(config, settings)

Builder = require(process.cwd() + '/lib/builder')
html_data     = Builder.build_html_data(settings)
settings_size = Object.keys(settings).length

describe 'Builder',  ->
  it 'Should build array of ' + settings_size + ' objects', () ->
    assert.equal html_data.length, settings_size

describe 'Compilation',  ->
  it 'Should compile all files from ' + config['mjml_src'] + ' directory', () ->
    for index, shop of html_data
      for template in shop['data']
        file_name = Builder.get_html_path config, shop['name'], template['name']
        expect(file(file_name)).to.exist
