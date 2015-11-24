// Generated by CoffeeScript 1.10.0
(function() {
  var Nested, Redemption, Resource, mongoose;

  mongoose = require('mongoose');

  Resource = require('../../src/resourcejs/Resource');

  Redemption = require('../../models/firefly/Redemption').model;

  Nested = require('./helpers/Nested');

  module.exports = function(app, model) {
    var resource;
    resource = Resource(app, '', 'Offers', model).patch({
      before: function(req, res, next) {
        var result, traverse;
        traverse = require('../../src/traverse');
        if (!((req.body != null) && (req.body[0] != null) && (req.body[0].op != null))) {
          result = traverse(req.body[0], '', []);
          req.body[0] = result[0];
        }
        return next();
      }
    }).index({
      after: function(req, res, next) {
        return Nested.find('offer', Redemption, 'redemptions', req.method, res.resource.item, function(error, result) {
          return next();
        });
      }
    }).get({
      after: function(req, res, next) {
        return Nested.find('offer', Redemption, 'redemptions', req.method, res.resource.item, function(error, result) {
          return next();
        });
      }
    })["delete"]();
    resource.modelName = resource.modelName.substring(0, resource.modelName.length - 1);
    return resource;
  };

}).call(this);

//# sourceMappingURL=Offer.js.map
