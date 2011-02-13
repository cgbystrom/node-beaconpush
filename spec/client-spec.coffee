require.paths.unshift __dirname + "/../node_modules"
vows = require('vows')
assert = require('assert')
beaconpush = require("../src/index")
Client = beaconpush.Client

API_KEY = 'c37c744dac99b19c9f5485d1967ace3f0d18914c'
SECRET_KEY = 'edd9f0bf37a1c8f5126fda468705ee9e83f7b698'

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



.export module

