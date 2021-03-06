// Generated by CoffeeScript 1.10.0
(function() {
  var assert, expect, mongoose, should;

  should = require('should');

  assert = require('chai').assert;

  expect = require('chai').expect;

  mongoose = require('mongoose');

  require('mongoose-schema-extend');

  describe('Model Tests', function() {
    it('Models load and return schema and model', function() {
      var Model, express, i, j, len, len1, models, name, results;
      express = require('express');
      models = ['AdviceTemplate', 'OfferTemplate', 'ServiceTemplate', 'Situation', 'TaskTemplate'];
      for (i = 0, len = models.length; i < len; i++) {
        name = models[i];
        Model = require('../models/admin/' + name);
        should.exist(Model);
        should.exist(Model.schema);
        should.exist(Model.model);
      }
      models = ['Event', 'Dealer', 'Chain', 'Reason', 'Redemption', 'Offer', 'ServiceItem'];
      results = [];
      for (j = 0, len1 = models.length; j < len1; j++) {
        name = models[j];
        Model = require('../models/firefly/' + name);
        should.exist(Model);
        should.exist(Model.schema);
        results.push(should.exist(Model.model));
      }
      return results;
    });
    return it('A SubClass loads and returns a schema', function() {
      var Model, express, i, j, len, len1, models, name, results;
      express = require('express');
      models = ['Maintenance', 'Triggerable'];
      for (i = 0, len = models.length; i < len; i++) {
        name = models[i];
        Model = require('../models/admin/' + name);
        should.exist(Model);
        should.exist(Model.schema);
        should.not.exist(Model.model);
      }
      models = ['Sendable', 'Redeemer'];
      results = [];
      for (j = 0, len1 = models.length; j < len1; j++) {
        name = models[j];
        Model = require('../models/firefly/' + name);
        should.exist(Model);
        should.exist(Model.schema);
        results.push(should.not.exist(Model.model));
      }
      return results;
    });
  });

}).call(this);

//# sourceMappingURL=ResourceModels_Tests.js.map
