version1 = require('./version1')

client_factory = (apiKey, secretKey, options) ->
  throw 'Invalid API key' unless apiKey.match /^\w{8,}$/
  throw 'Invalid secret key' unless secretKey.match /^\w{15,}$/
  return new version1(apiKey, secretKey, options)

module.exports = client_factory

