should = require('should')
assert = require('chai').assert
expect = require('chai').expect
mongoose = require('mongoose');
require('mongoose-schema-extend')

describe 'Model Tests', ->
    it 'Models load and return schema and model', () ->
        express = require('express')
        models = ['AdviceTemplate','OfferTemplate',
                  'ServiceTemplate','Situation','TaskTemplate']
        for name in models
            Model = require('../models/admin/'+name)
            should.exist(Model)
            should.exist(Model.schema)
            should.exist(Model.model)

        models = ['Event','Dealer','Chain',
                  'Reason','Redemption','Offer',
                  'ServiceItem']
        for name in models
            Model = require('../models/firefly/'+name)
            should.exist(Model)
            should.exist(Model.schema)
            should.exist(Model.model)

    it 'A SubClass loads and returns a schema', () ->
        express = require('express')
        models = ['Maintenance', 'Triggerable']
        for name in models
            Model = require('../models/admin/'+name)
            should.exist(Model)
            should.exist(Model.schema)
            should.not.exist(Model.model)

        models = ['Sendable', 'Redeemer']
        for name in models
            Model = require('../models/firefly/'+name)
            should.exist(Model)
            should.exist(Model.schema)
            should.not.exist(Model.model)
