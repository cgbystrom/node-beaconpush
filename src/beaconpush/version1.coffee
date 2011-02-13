# Implementation of Beaconpush REST API version 1

#beaconPush.usersConnected

#beaconpush.user("charlie").connected
#beaconpush.user("charlie").send({"apa": 123})
#beaconpush.user("charlie").disconnect()


#beaconpush.channel("forum").usersConnected
#beaconpush.channel("forum").send({"myMessage": "sdsdf})

request = require('request')
sys = require 'sys'

clone = (o) ->
  c = {}
  for k, v of o
    c[k] = v
  c 

class User
  constructor: (client, name) ->
    @client = client
    @name = name
    @url = @client.url + '/users/' + @name

  isConnected: (callback) ->
    request {uri: @url, headers: @client.headers}, (err, response, body) ->
      connected = not err and response.statusCode == 200
      callback(err, connected)
  
  disconnect: (callback) ->
    headers = clone(@headers)
    headers["Content-Length"] = '0'
    request {uri: @url, method: 'DELETE', headers: headers}, (err, response, body) ->
      if not err and response.statusCode isnt 204
        err = "Unexpected response code: " + response.statusCode
      callback(err)
  
  send: (message, callback) ->
    request {uri: @url, method: 'POST', headers: @client.headers, json: message}, (err, response, body) ->
      numDelivered = undefined
      if not err and response.statusCode is 200
        numDelivered = JSON.parse(body).messages_sent
      callback(err, numDelivered)

class Client
  version: '1'
  constructor: (apiKey, secretKey, options) ->
    @apiKey = apiKey
    @secretKey = secretKey
    @headers = {'X-Beacon-Secret-Key': @secretKey}
    @url = 'http://api.beaconpush.com/1.0.0/' + @apiKey

  user: (name) ->
    # TODO: Check valid username
    new User(this, name)


module.exports = Client
