// Generated by CoffeeScript 1.10.0
(function() {
  var Resource, async, mongoose;

  mongoose = require('mongoose');

  Resource = require('../../src/resourcejs/resource');

  async = require('async');

  module.exports = function(app, model) {
    var resource;
    resource = Resource(app, '/chains/:chainId', 'Dealers', model).rest({
      before: function(req, res, next) {
        req.body.chain = req.params.chainId;
        req.modelQuery = this.model.where('chain', req.params.chainId);
        return next();
      }
    }).patch({
      before: function(req, res, next) {
        var result, traverse;
        traverse = require('../../src/traverse');
        if (!((req.body != null) && (req.body[0] != null) && (req.body[0].op != null))) {
          result = traverse(req.body[0], '', []);
          req.body[0] = result[0];
        }
        return next();
      }
    });
    resource.modelName = resource.modelName.substring(0, resource.modelName.length - 1);
    return resource;
  };

}).call(this);

//# sourceMappingURL=ChainDealer.js.map
