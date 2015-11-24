mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Dealer = require('../../models/firefly/Dealer').model
Nested = require './helpers/Nested'
module.exports = (app, model) ->
    resource = Resource(app, '', 'Chains', model).rest({
        after: (req, res, next) ->
            console.log("Index Request after")
            Nested.find('chain', Dealer, 'dealers', req.method, res.resource.item, (error, result) ->
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
