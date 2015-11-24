async = require 'async'
Vehicle = require('../models/firefly/Vehicle').model

module.exports = (app) ->

    app.use((req,res,next) ->
        next()

    )
    return 