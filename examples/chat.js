var express = require('express');
var beaconpush = require('beaconpush');
var app = express.createServer();

var apiKey = null; // Replace with your key from your account page on Beaconpush
var secretKey = null; // Replace with your key from your account page on Beaconpush
if (!apiKey || !secretKey) {
  console.log('Please set your API and secret key. See chat.js');
  process.exit(1);
}

beaconpush = new beaconpush.Client(apiKey, secretKey);

app.set('view options', {layout: false});
app.set('views', __dirname);
app.use(express.bodyDecoder());

app.get('/', function(req, res){
  res.render('chat.ejs', {
    locals: {apiKey: apiKey}
  });
});

app.post('/messages', function(req, res) {
  beaconpush.channel('chat').send(req.body, function (err, numDelivered) {
    res.send({result: 'sent'});
  });
});

app.listen(3000);

