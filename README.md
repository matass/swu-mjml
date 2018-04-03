# swu-mjml
Automagically compile MJML templates to responsive HTML and easily update new versions to Sendwithus platform

Slack: https://join.slack.com/t/swu-mjml/signup

![](https://image.ibb.co/fq0syk/Screen_Shot_2017_09_21_at_4_41_01_PM.png)

#### MJML
This package compiles <b>MJML</b> templates to responsive HTML email templates.
> <b>MJML</b> is a markup language designed to reduce the pain of coding a responsive email. Its semantic syntax makes it easy and straightforward and its rich standard components library speeds up your development time and lightens your email codebase. MJML's open-source engine generates high quality responsive HTML compliant with best practices.
[Read more about <b>MJML</b>](https://mjml.io/)

#### Sendwithus
This Package uses <b>Sendwithus</b> API to update templates
> <b>Sendwithus</b> helps marketers ensure their transactional and triggered emails are awesome, with template management, testing, and analytics
[Read more about <b>Sendwithus</b>](sendwithus.com)

If you want to get all templates with their versions, you have to make a GET request to `api.sendwithus.com`.
* Set `X-SWU-API-KEY` header key (you can find your API key in [Sendwithus api settings](https://app.sendwithus.com/#/api_settings))
* Make `GET` request to `https://api.sendwithus.com/api/v1/templates` URL

# Installation

`npm install swu-mjml`

# API

Create configuration and templates settings
```javascript
var config = {
  swu_api_key: 'test_xxx',
  path: 'test/templates',
  mjml_src: 'test/mjml',
  views_path: 'test/views/index',
  port: 3001
};

var mjml_templates = {
  example1: {
    racoon1: { id: 'tem_xxx', version: 'ver_xxx' },
    racoon2: { id: 'tem_xxx', version: 'ver_xxx' }
  },
  example2: {
    racoon1: { id: 'tem_xxx', version: 'ver_xxx' }
  }
}
```

Start swu-mjml
```javascript
var swu_mjml = require('swu-mjml')(config, mjml_templates);
swu_mjml.start()
```

* You have correctly define `mjml_src` path in `config` object.
* Make sure that templates settings matches `mjml_src` folder structure.

# Running demo app
- Run `npm start` to compile `lib` directory from source
- Run `node demo.js`

##### By default
- use `localhost:3001` to list all local templates
- use `localhost:3001/swu-templates` to get response from sendwithus API about all templates and their versions

# Testing
`npm test`
