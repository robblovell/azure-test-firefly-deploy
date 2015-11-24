mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
ServiceItem = require('../../models/firefly/ServiceItem').model
Offer = require('../../models/firefly/Offer').model

Nested = require './helpers/Nested'
module.exports = (app, model) ->
    resource = Resource(app, '', 'Vehicles', model).rest({
        after: (req, res, next) ->
            if req.headers? and req.headers.nested? and (req.headers.nested is 'true' or req.headers.nested is true)
                console.log("finding service items")
                Nested.find('vehicle', ServiceItem, 'serviceitems', req.method, res.resource.item, (error, result) ->
                    console.log("found service items: ")
                    Nested.find('serviceitem', Offer, 'offers', req.method, res.resource.item, (error, result) ->
                        console.log("found service item offers: ")
                        next()
                        return
                    )
                    return
                )
                return
            else
                next()
    })
    resource.modelName = resource.modelName.substring(0,resource.modelName.length-1)
    return resource
