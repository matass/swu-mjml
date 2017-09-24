Builder = -> return

Builder::build_html_data = (settings) ->
  data = 
    for shop, template of settings
      name: shop
      data:
        for tmp, data of template
          name: tmp,
          id: data.id,
          version: data.version
  return data

Builder::build_template_body = (body, data) ->
  id: body.template_id,
  version: body.template_version,
  name: Math.random().toString(36).substring(2),
  subject: body.template_name,
  html: data

Builder::get_html_path = (CONFIG, shop, template) ->
  process.cwd() + '/' + CONFIG.path + '/' + shop + '/' + template + '.html'

module.exports = new Builder
