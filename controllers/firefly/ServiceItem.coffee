mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Vehicle = require('../../models/firefly/Vehicle').model
Offer = require('../../models/firefly/Offer').model
Nested = require './helpers/Nested'
module.exports = (app, model) ->
    # Create the REST resource.
    resource = Resource(app, '', 'ServiceItems', model).patch({
        before: (req, res, next) ->
            traverse = require('../../src/traverse')

            if not(req.body? and req.body[0]? and req.body[0].op?)
                result = traverse(req.body[0],'', [])
                req.body[0] = result[0]
            next()
    }).index({
        after: (req, res, next) ->
            Nested.find('serviceitem', Offer, 'offers', req.method, res.resource.item, (error, result) ->
                next()
            )
    }).get({
        before: (req, res, next) ->
            console.log('before')
            next()
        after: (req, res, next) ->
            Nested.find('serviceitem', Offer, 'offers', req.method, res.resource.item, (error, result) ->
                next()
            )
    }).delete()
    resource.modelName = resource.modelName.substring(0,resource.modelName.length-1)
    return resource
