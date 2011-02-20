node-beaconpush
===============

A fast and easy-to-use node.js client for [Beaconpush](http://beaconpush.com), a cloud hosted service for browser push messaging with Web Sockets.

Example
-------
Sends a message to a connected web browser:

    var bp = require('beaconpush');

    // Create a new client
    var beaconpush = new bp.Client('<your-api-key>', '<your-secret-key>');
    
    // Send a 'chatMessage' to user 'romeo'
    beaconpush.user('romeo').send({chatMessage: 'ZOMG'});

A more detailed chat example is available in the [examples](https://github.com/cgbystrom/node-beaconpush/tree/master/examples) directory.

What is Beaconpush?
-------------------

Beaconpush is a cloud service offering push messaging in any web browser.
Send messages in real-time to any browser by using a simple REST API.
Integrates smoothly with all existing web frameworks and libraries.

* **No requirements**<br>
Just embed a couple of lines of JavaScript on your web site. No software, no servers required.

* **Works in any browser**<br>
Excellent browser compatibility no matter what. If Web Sockets isn't available, it will automatically try other transport alternatives.

* **User and channel presence**<br>
First-class support for users making real-time, social sites a snap to create. Detect if user is online/offline or create chat rooms!

* **Scalable**<br>
With high-performing, custom-written push server technology, Beaconpush will take care of all scalability needs for you.

Read more on [beaconpush.com](http://beaconpush.com)

Installation
---------------

With [Node Package Manager](http://npmjs.org/) installed, just type:

    npm install beaconpush


API Examples
--------

    var bp = require('beaconpush');
    
    // Create a new client
    var beaconpush = new bp.Client('<your-api-key>', '<your-secret-key>');
    
    // Get number of users currently connected to your site
    beaconpush.usersConnected(function (numConnected) {
      console.log('There are ' + numConnected + ' users online');
    });


    // Get a user object where you do user operations
    var user = beaconpush.user('julia');

    // Send a stock quote to user 'julia'
    user.send({stock: {symbol: "GOOG", quote: 34.2}}, function (err, numDelivered) {
      console.log('Delivered ' + numDelivered + ' message(s)');
    });

    // Check if user is online
    user.isConnected(function (err, connected) {
      console.log('User ' + user.name + ' is ' + (connected ? 'connected' : 'not connected'));
    });
    
    // Disconnect user
    user.disconnect(function (err, connected) {
      console.log('User ' + user.name + ' was disconnected');
    });


    // Get a channel object for doing channel operations
    var channel = beaconpush.channel('chat');

    // Send a chat message to channel
    channel.send({chatMessage: {to: "romeo", from: "julia", message: "Oh, Romeo!"}}, function (err, numDelivered) {
      console.log('Delivered ' + numDelivered + ' message(s)');
    });

    // Get users connected to a channel
    channel.usersConnected(function (err, users) {
      console.log('Users online ' + users);
    });


<script src="https://gist.github.com/836224.js?file=node-beaconpush_example.js"></script>

Authors
-------

- Carl Bystr&ouml;m ([@cgbystrom](http://twitter.com/cgbystrom))

License
-------

Open-source licensed under the MIT license (see _LICENSE_ file for details).

