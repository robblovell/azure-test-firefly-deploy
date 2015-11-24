async = require('async')
mongoose = require('mongoose')
Resource = require('../../../src/resourcejs/Resource')
module.exports = class Nested
    constructor: () ->
    @find: (parentFiled, Child, childField, method, resources, callback) ->
        console.log("after")
        if (method is "GET")
            console.log("GET/INDEX")
            if (resources? and resources instanceof Array)
                console.log("Index Request after")
                finds = []
                for resource in resources
                    finds.push((cb) ->
                        query = {}
                        query[parentFiled] = resource._doc._id.toString()
                        Child.find(query, (error, result) ->
                            if error?
                                console.log("Error:"+error )
                                req.res.resource.item._doc[childField] = error
                            else if result?
                                console.log("Result:"+JSON.stringify(result))
                                resource._doc[childField] = result
                            cb(error,result)
                        )
                    )
                async.series(finds, (error, result) ->
                    if (error?)
                        console.log("Error:"+error )

                    callback(error, resources)
                )
            else
                console.log("Get Request after")
                if (resources?)
                    resource = resources
                    query = {}

                    query[parentFiled] = resource._doc._id.toString()
                    Child.find(query, (error, result) ->
                        if error?
                            console.log("Error:"+error )
                            req.res.resource.item._doc[childField] = error
                        else if result?
                            console.log("Result:"+JSON.stringify(result))
                            resource._doc[childField] = result
                        callback(error, resources)
                    )
                else
                    callback("Not Found", null)
        else
            callback(null, resources)
