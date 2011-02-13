require.paths.unshift __dirname + "/../node_modules"
vows = require('vows')
assert = require('assert')
beaconpush = require("../src/index")
sys = require('sys')
Client = beaconpush.Client

API_KEY = 'REPLACE'
SECRET_KEY = 'REPLACE'

vows.describe('Beaconpush REST API v1 Client').addBatch
  'A Client':
    'during setup should':
      'accept a valid API key and secret key': ->
        assert.doesNotThrow (-> new Client('abc37bfe', 'abe8dd82aef932fe1a8c')), String
      'reject an invalid API key': ->
        assert.throws (-> new Client('ab##!c37bfe', 'abe8dd2fe1a8c')), "Invalid API key"
      'reject an invalid secret key': ->
        assert.throws (-> new Client('abc37bfe', 'abe8###!dd2fe1a8c')), "Invalid secret key"
      'default to API version 1': ->
        assert.equal new Client('abc37bfe', 'abe8efa42efdd2fe1a8c').version, '1'

    'can check number of users connected':
      topic: -> new Client(API_KEY, SECRET_KEY).usersConnected @callback
      'after a successful': (err, numConnected) -> assert.equal numConnected, 0

    'with a user can':
      topic: new Client(API_KEY, SECRET_KEY).user('charlie')
      'check if that user is online':
        topic: (user) -> user.isConnected @callback
        'after a successful response': (err, isConnected) -> assert.isFalse isConnected

      'disconnect that user':
        topic: (user) -> user.disconnect @callback
        'after a successful response': (err) -> assert.isUndefined err

      'send a message to that user':
        topic: (user) -> user.send {foo: "ZOMG"}, @callback
        'after a successful response': (err, numDelivered) -> assert.isTrue numDelivered >= 1

    'with a selected channel can':
      topic: new Client(API_KEY, SECRET_KEY).channel('chat')
      'send a message to all users in channel':
        topic: (channel) -> channel.send {foo: "ZOMG"}, @callback
        'after a successful response': (err, numDelivered) -> assert.isTrue numDelivered >= 1
        
      'list all users in channel':
        topic: -> new Client(API_KEY, SECRET_KEY).channel('chat').usersConnected @callback
        'after a successful response': (err, users) ->
          assert.isArray users
          assert.length users, 0

      'list all users in channel':
        topic: -> new Client(API_KEY, SECRET_KEY).channel('chat').usersConnected @callback
        'after a succesful response': (err, users) ->
          assert.isArray users
          assert.length users, 0


#      'disconnect that user':
#        topic: (user) -> user.disconnect @callback
#        'after a successful response': (err) -> assert.isUndefined err

#      'send a message to that user':
#        topic: (user) -> user.send {foo: "ZOMG"}, @callback
#        'after a successful response': (err, numDelivered) -> assert.isTrue numDelivered >= 1


.export module

