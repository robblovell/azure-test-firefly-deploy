mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
async = require('async')

module.exports = (app, model) ->
    resource = Resource(app, '/offers/:offerId', 'Redemptions', model).rest({
        before: (req, res, next) ->
            req.body.offer = req.params.offerId
            req.modelQuery = this.model.where('offer', req.params.offerId)
            next()
        after: (req, res, next) ->
            console.log("after")
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