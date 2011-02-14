node-beaconpush
===============

A fast and easy-to-use node.js client for [Beaconpush](http://beaconpush.com), a cloud hosted service for browser push messaging.

Example
-------
Sends a message to a connected web browser:

    // Create a new client
    var beaconpush = new Client('<your-api-key>', '<your-secret-key>');
    
    // Send a 'chatMessage' to user 'charlie'
    beaconpush.user('charlie').send({chatMessage: 'ZOMG'});

What is Beaconpush?
-------------------

Beaconpush is a cloud service offering push messaging in any web browser.
Send messages in real-time to any browser by using a simple REST API.
Integrates smoothly with all existing web frameworks and libraries.

* **No requirements**
Just embed a couple of lines of JavaScript on your web site. No software, no servers required.

* **Works in any browser**
Excellent browser compatibility no matter what. If Web Sockets isn't available, it will automatically try other transport alternatives.

* **User and channel presence**
First-class support for users making real-time, social sites a snap to create. Detect if user is online/offline or create chat rooms!

* **Scalable**
With high-performing, custom-written push server technology, Beaconpush will take care of all scalability needs for you.

Read more on [beaconpush.com](http://beaconpush.com)

Authors
-------

- Carl Bystr&ouml;m <http://www.pedantique.org/>

License
-------

Open-source licensed under the MIT license (see _LICENSE_ file for details).

