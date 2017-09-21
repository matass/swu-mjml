restler = require('restler')

Sendwithus = (@API_KEY = api_key) ->
  return

Sendwithus::_callback = ->
  if err
    console.log err.statusCode, response
  else
    response
  return

Sendwithus::_buildUrl = (resource) ->
  url = 'https://api.sendwithus.com/api/v1/' + resource

Sendwithus::_headers = ->
  headers = []
  headers:
    'X-SWU-API-KEY': @API_KEY

Sendwithus::update_template = (data, @_callback) ->
  url = @_buildUrl('templates/' + data.id + '/versions/' + data.version)

  restler.putJson(url, data, @_headers()).once 'complete', (result, response) ->
    console.log result
    return
  return

module.exports = (api_key) ->
  new Sendwithus(api_key)
