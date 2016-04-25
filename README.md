# zookeeper-reconnect
A zookeeper client that automatically reconnects on session timeouts

## Usage

```javascript
var Zookeeper = require('zookeeper-reconnect');
var zk = new Zookeeper ('your zookeeper connection string', options);

zk.on('connected', function(client){
  //You are now connected to ZK
  //It will be called the first time you connect to ZK and when reconnecting
  //after disconnection or session loss.

  client.getData('/path', watchHandler, function(err, data){
    // work with your ZK data
  })
})

//You could also use it outside the callback
if (zk.connected){
  zk.client.getData(function('/path', watchHandler, function(err, data){
    //Work with your ZK data
  });
}
```
