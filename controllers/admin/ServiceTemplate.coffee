mongoose = require('mongoose')
Resource = require('../../src/resourcejs/Resource')

module.exports = (app, model) ->
    return Resource(app, '', 'ServiceTemplates', model).rest()
#    .patch({
#        before: (req, res, next) ->
#            traverse = require('../src/traverse')
#
#            if not(req.body? and req.body[0]? and req.body[0].op?)
#                result = traverse(req.body[0],'', [])
#                req.body[0] = result[0]
#            next()
#    }).get().put().post().delete().index()
