request    = require 'request'

Sendwithus = (@API_KEY = api_key) ->
  return

Sendwithus::build_url = (resource) ->
  url = 'https://api.sendwithus.com/api/v1/' + resource

Sendwithus::headers = -> 'X-SWU-API-KEY': @API_KEY

Sendwithus::update_template = (data) ->
  url = @build_url('templates/' + data.id + '/versions/' + data.version)

  request.put { url, json: data, headers: @headers() }, (err, req, result) ->
    console.log result
    return
  return

Sendwithus::get_templates = (callback) ->
  url = @build_url('templates')

  request.get { url, headers: @headers() }, (err, req, result) ->
    callback null, JSON.parse r.result
    return
  return

module.exports = (api_key) -> new Sendwithus(api_key)
