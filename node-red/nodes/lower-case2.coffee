module.exports = (RED) ->
    LowerCaseNode = (config) ->
        RED.nodes.createNode(@,config)
        node = @
        @on('input', (msg) ->
            msg.payload = msg.payload.toLowerCase()
            node.send(msg)
        )
        return
    RED.nodes.registerType("lower-case2",LowerCaseNode)
    return
