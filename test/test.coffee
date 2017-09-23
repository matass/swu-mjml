expect   = require('chai').expect
assert   = require('chai').assert
settings = 
  templates:
    version_1: template_1:
      id: 'tem_xxx'
      version: 'ver_xxx'

    version_2: template_1:
      id: 'tem_xxx'
      version: 'ver_xxx'

    version_3: template_3:
      id: 'tem_xxx'
      version: 'ver_xxx'

Builder = require(process.cwd() + '/lib/builder')

describe 'Builder',  ->
  it 'should build array of 3 objects', () ->
    html_data = Builder.build_html_data(settings)
    assert.equal html_data.length, 3
