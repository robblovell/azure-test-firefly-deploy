should = require('should')
assert = require('chai').assert
expect = require('chai').expect
mongoose = require('mongoose');
require('mongoose-schema-extend')

describe 'Controller Tests', ->
    it 'controllers load with the right naming scheme', () ->
        express = require('express')
        app = express()
        models = ['ServiceTemplates','Situations']
        for name in models
            model = require('../models/admin/'+name.slice(0,name.length-1))
            Model = require('../controllers/admin/'+name.slice(0,name.length-1))(app, model)
            expect(Model.modelName).to.equal(name)
            expect(Model.name).to.equal(name.toLowerCase())
            should.exist(Model.model)

        models = ['ServiceItems','Chains','Offers','Redemptions','Vehicles']
        for name in models
            model = require('../models/firefly/'+name.slice(0,name.length-1))
            Model = require('../controllers/firefly/'+name.slice(0,name.length-1))(app, model)
            expect(Model.modelName).to.equal(name)
            expect(Model.name).to.equal(name.toLowerCase())
            should.exist(Model.model)

        models = ['ChainDealers','OfferRedemptions']
        names = ['Dealers', 'Redemptions']
        for name,i in models
            Model = require('../controllers/firefly/'+name.slice(0,name.length-1))(app, model)
            expect(Model.modelName).to.equal(names[i])
            expect(Model.name).to.equal(names[i].toLowerCase())
            should.exist(Model.model)

