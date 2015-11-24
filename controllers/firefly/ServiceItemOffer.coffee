mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Redemption = require('../../models/firefly/Redemption').model
Nested = require './helpers/Nested'
module.exports = (app, model) ->
    resource = Resource(app, '/serviceitems/:serviceitemId', 'Offers', model).rest({
        before: (req, res, next) ->
            req.body.serviceitem = req.params.serviceitemId
            req.modelQuery = this.model.where('serviceitem', req.params.serviceitemId)
            next()
        after: (req, res, next) ->
            console.log("after")
            Nested.find('offer', Redemption, 'redemptions', req.method, res.resource.item, (error, result) ->
                next()
            )
            next()
    }).patch({
        before: (req, res, next) ->
            traverse = require('../../src/traverse')

            if not(req.body? and req.body[0]? and req.body[0].op?)
                result = traverse(req.body[0],'', [])
                req.body[0] = result[0]
            next()
    })
    resource.modelName = resource.modelName.substring(0,resource.modelName.length-1)
    return resource