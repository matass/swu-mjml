# swu_mjml
Automagically compile MJML templates to responsive HTML and easily update new versions to Sendwithus platform

[![Build Status](https://travis-ci.org/matass/swu_mjml.svg?branch=master)](https://travis-ci.org/matass/swu_mjml)

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

# Installation:
`npm install swu_mjml`

# Testing:
`npm test`

# Demo

Configure `demo.js` file and run `node demo.js` 
