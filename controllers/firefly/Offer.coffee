mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Redemption = require('../../models/firefly/Redemption').model
Nested = require './helpers/Nested'
module.exports = (app, model) ->
    resource = Resource(app, '', 'Offers', model).patch({
        before: (req, res, next) ->
            traverse = require('../../src/traverse')

            if not(req.body? and req.body[0]? and req.body[0].op?)
                result = traverse(req.body[0],'', [])
                req.body[0] = result[0]
            next()
    }).index({
        after: (req, res, next) ->
            Nested.find('offer', Redemption, 'redemptions', req.method, res.resource.item, (error, result) ->
                next()
            )
    }).get({
        after: (req, res, next) ->
            Nested.find('offer', Redemption, 'redemptions', req.method, res.resource.item, (error, result) ->
                next()
            )
    }).delete()
    resource.modelName = resource.modelName.substring(0,resource.modelName.length-1)
    return resource

