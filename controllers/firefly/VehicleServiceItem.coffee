mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Offer = require('../../models/firefly/Offer').model
Nested = require './helpers/Nested'
module.exports = (app, model) ->
    resource = Resource(app, '/vehicles/:vehicleId', 'ServiceItems', model).rest({
        before: (req, res, next) ->
            req.body.vehicle = req.params.vehicleId
            req.modelQuery = this.model.where('vehicle', req.params.vehicleId)
            next()
        after: (req, res, next) ->
            Nested.find('serviceitem', Offer, 'offers', req.method, res.resource.item, (error, result) ->
                next()
            )
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