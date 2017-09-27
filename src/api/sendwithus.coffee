restler = require('restler')

Sendwithus = (@API_KEY = api_key) ->
  return

Sendwithus::build_url = (resource) ->
  url = 'https://api.sendwithus.com/api/v1/' + resource

Sendwithus::headers = ->
  headers = []
  headers:
    'X-SWU-API-KEY': @API_KEY

Sendwithus::update_template = (data) ->
  url = @build_url('templates/' + data.id + '/versions/' + data.version)

  restler.putJson(url, data, @headers()).once 'complete', (result, response) ->
    console.log result
    return
  return

Sendwithus::get_templates = (callback) ->
  url = @build_url('templates')
  restler.get(url, @headers()).once 'complete', (result, response) ->
    callback null, result
    return
  return

module.exports = (api_key) -> new Sendwithus(api_key)
