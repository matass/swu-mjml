var mjml_templates = {
  example1: {
    racoon1: { id: 'tem_xxx', version: 'ver_xxx' },
    racoon2: { id: 'tem_xxx', version: 'ver_xxx' }
  },
  example2: {
    racoon1: { id: 'tem_xxx', version: 'ver_xxx' }
  }
}

var config = {
  swu_api_key: 'test_xxx',
  path: 'test/templates',
  mjml_src: 'test/mjml',
  views_path: 'test/views/index',
  port: 3001
};

require('./lib/swu_mjml')(config, mjml_templates);
