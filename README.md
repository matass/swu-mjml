# swu_mjml
Automagically compile MJML templates to responsive HTML and easily update new versions to Sendwithus platform

![](https://image.ibb.co/fq0syk/Screen_Shot_2017_09_21_at_4_41_01_PM.png)

#### MJML
This package compiles <b>MJML</b> templates to responsive HTML email templates.
> <b>MJML</b> is a markup language designed to reduce the pain of coding a responsive email. Its semantic syntax makes it easy and straightforward and its rich standard components library speeds up your development time and lightens your email codebase. MJML's open-source engine generates high quality responsive HTML compliant with best practices.
[Read more about <b>MJML</b>](https://mjml.io/)

#### Sendwithus
This Package uses <b>Sendwithus</b> API to update templates
> <b>Sendwithus</b> helps marketers ensure their transactional and triggered emails are awesome, with template management, testing, and analytics
[Read more about <b>Sendwithus</b>](sendwithus.com)

# Dependencies:
`ejs` `express` `gulp` `gulp-mjml` `merge-stream` `mjml` `path` `restler`

# Installation:
`npm install swu_mjml`

# Usage

This package works automagically.
All you need to do is to correctly define sendwitus template ID
with version and place MJML files in specific directories.

##### settings.coffee
```coffeescript
config = []

config = 
  default:
    test_tmp_1:
      id: 'tem_WGS2g8tjdSBtZUNjdGjPK'
      version: 'ver_DDZVKmcz2W9pSykaGxjZGN'

exports.templates = config
```
##### index.coffee
```coffeescript
settings = require './settings'

config =
  swu_api_key: 'YOU_SWU_API_KEY'
  path: 'templates'
  mjml_src: 'mjml'
  views_path: 'views/index'
  api_path: 'api'
  port: 3001

require('swu_mjml')(config, settings)
```

##### views/index.ejs
```ejs
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
    <script>
      $(function(){
        $('.update').click(function() {
          var data = {};
          var $this = $(this);

          data.shop             = $this.data('shop')
          data.template_id      = $this.data('template-id')
          data.template_version = $this.data('template-version')
          data.template_name    = $this.data('template-name')

          $.ajax({
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json',
            url: 'http://localhost:<%= port %>/<%= api_path %>';
          });
        });
      });
    </script>
  </head>
  <body>
    <% shops.forEach(function(shop) { %>
      <table class="mdl-data-table" style="float: left">
        <thead>
          <tr>
            <th><%= shop.name %></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <% shop.data.forEach(function(template) { %>
            <tr>
              <td>
                <a href="<%= shop.path %>/<%= shop.name %>/<%= template.name %>"> <%= template.name %> </a>
              </td>
              <td>
                <button class="update mdl-button mdl-js-button" onclick="return confirm('Are you sure?')"
                  data-shop="<%= shop.name %>"
                  data-template-id="<%= template.id %>"
                  data-template-version="<%= template.version %>"
                  data-template-name="<%= template.name %>">Update</button>
              </td>
            </tr>
          <% }); %>
        </tbody>
      </table>
    <% }); %>
  </body>
</html>
```

##### Structure
````
├── ...
├── index.coffee
├── settings.coffee
├── mjml
│   └── default
│       └── test_tmp_1.mjml
├── html
│   └── default
│       └── test_tmp_1.html
├── views
│   └── index.ejs
└── ...
````
