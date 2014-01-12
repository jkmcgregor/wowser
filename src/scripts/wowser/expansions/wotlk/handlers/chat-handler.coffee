# Denotes a chat handler
class Wowser.expansions.wotlk.handlers.ChatHandler
  @include Backbone.Events

  # Imports
  Message = Wowser.entities.Message
  WorldOpcode = Wowser.expansions.wotlk.enums.WorldOpcode
  WorldPacket = Wowser.expansions.wotlk.net.WorldPacket

  # Creates a new chat handler
  constructor: (session) ->

    # Holds session
    @session = session

    # Holds messages
    @messages = []

    # Listen for messages
    @session.world.on 'packet:receive:SMSG_MESSAGE_CHAT', @handleMessage, @

  # Sends given message
  send: (message) ->
    throw new Error 'Sending chat messages is not yet implemented'

  # Message handler (SMSG_MESSAGE_CHAT)
  handleMessage: (wp) ->
    type = wp.readUnsignedByte()
    lang = wp.readUnsignedInt()
    guid1 = wp.readGUID()
    wp.readUnsignedInt()
    guid2 = wp.readGUID()
    len = wp.readUnsignedInt()
    text = wp.readString(len)
    flags = wp.readUnsignedByte()

    message = new Message()
    message.text = text
    message.guid = guid1

    @messages.push(message)

    @trigger 'message', message