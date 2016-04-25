zookeeper = require 'node-zookeeper-client'
EventEmitter = require 'eventemitter3'

class Zookeeper extends EventEmitter
  module.exports = Zookeeper

  constructor: (@connectionString, @options)->
    @connected = false
    @reconnect = true

    @_initClient()

  _initClient: =>
    @client = zookeeper.createClient @connectionString, @options
    @client.connect()

    console.log 'Connecting to Zookeeper'
    @client.on 'connected', =>
      console.log 'Connected to Zookeeper'
      @connected = true
      @emit 'connected', @client

    @client.on 'disconnected', =>
      console.log 'Disconnected from Zookeeper'
      @connected = false
      @emit 'disconnected'

    @client.on 'connectedReadOnly', =>
      console.log 'Connected to Zookeeper read only'

    @client.on 'expired', =>
      console.log 'Zookeeper session expired'
      @emit 'expired'
      @_initClient() if @reconnect

    @client.on 'authenticationFailed', =>
      console.log 'Zookeeper authentication failed'

  close: ()=>
    if @connected
      @client.close()
