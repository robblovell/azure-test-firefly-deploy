mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')
Vehicle = require('../../models/firefly/Vehicle').model
ServiceItem = require('../../models/firefly/ServiceItem').model
ServiceTemplate = require('../../models/admin/ServiceTemplate').model
_ = require('underscore')
async = require('async')

module.exports = (app, model) ->
    return Resource(app, '/servicetemplates/:servicetemplateId', 'Vehicles', model).post({
        before: (req, res, next) ->
            console.log("PUT serviceTemplate/id/Vehicles")
            # create a serviceitem for all mojiovehicles given.
            # loop through the mojio vehicles
            ServiceTemplate.findById(req.params.servicetemplateId, (error, result) ->
                template = result
                funcs = []
                for vehicleId in req.body # array of strings representing ids.
                    console.log("Create for vehicle"+vehicleId)

                    # for each one, see if it exists.
                    funcs.push((cb) ->
                        ServiceItem.findOne({servicetemplate: template.id, vehicle: vehicleId}, (error, result) ->
                            if (error or !result? or result.length == 0)
                                serviceItem = {
                                    given: Date.now()
                                    reasons: [{name: 'triggered', source: 'wizard' }]
                                    times: 1
                                    vehicle: vehicleId
                                    servicetemplate: template.id
                                    name: template.name
                                    description: template.description
                                    artwork: template.artwork
                                    icon: template.icon
                                    offers: []
                                    advice: []
                                    tasks: template.tasks
                                }
                                item = new ServiceItem(serviceItem)
                                item.save((error) ->
                                    cb(error, item)
                                    return
                                )
                            else
                                cb(error, result)
                            return
                        )
                        return
                    )
                async.parallel(funcs, (error, result) ->
                    if (error)
                        res.render('error', {
                            error: { status: "Error creating ServiceItems", stack:"From controllers/ServiceTemplateMojioVehicle"},
                            message: 'Error is'+error.message
                        })
                        return
                    else
                        console.log("results"+result)
                        res.sendStatus(200)
                        return
                )
            )
            return
    })
#    .delete(
#        before: (req, res, next) ->
#            res.render('error', {
#                error: { status: "Not Implemented", stack:"From controllers/ServiceTemplateMojioVehicle"},
#                message: 'Delete ServiceTemplate/MojioVehicle Not Implemented'
#            })
#    )