proxyquire = require('proxyquire')
pathStub   =  { }

should = require('should')
assert = require('chai').assert
expect = require('chai').expect
express = require('express')
nock = require('nock')

Vehicle = require('../models/firefly/Vehicle').model
app = express()
[getToken, getMe, getVehicle, getMojioVehicle, createVehicle] = require('../src/auth')(app)

describe 'Authorization Tests', ->
    token = {access_token: 'token'}
    results = {token: token}

    it 'getToken should get a token', (done) ->

        (getToken!=null).should.be.true

        getToken(token, (error, result) ->
            result.token.should.be.equal(token)
            done()
            return
        )

    it 'getMe should get a user', (done) ->
        (getMe!=null).should.be.true
        nock('https://staging-api.moj.io')
        .get("/v2/me")
        .reply((uri, requestBody, cb) ->
            cb(null, [200, JSON.stringify({Id: "id"})])
            return
        )
        getMe(results, (error, result) ->
            results.mojioUser.Id.should.be.equal("id")
            done()
            return
        )

    it 'getVehicle should get a firefly vehicle-user object', (done) ->
        (getVehicle!=null).should.be.true
        results.mojioUser.Id.should.be.equal("id")
        Vehicle.find = (query, callback) ->
            console.log("find vehicle")
            callback(null, [{_doc: {Id: 'vehicleId'}, save: (error, result)->
                console.log("save vehicle")
                callback(null)
                this._doc._id = 'vehicleId'
            }])
        getVehicle(results, (error, result) ->
            result.vehicles[0].Id.should.be.equal("vehicleId")
            done()
            return
        )

    it 'getMojioVehicle should get a mojio vehicle', (done) ->
        (getMojioVehicle!=null).should.be.true
        nock('https://staging-api.moj.io')
        .get("/v2/Vehicles")
        .reply((uri, requestBody, cb) ->
            cb(null, [200, JSON.stringify({Data: [{Id: "id"}]})])
            return
        )
        getMojioVehicle(results, (error, result) ->
            results.mojioVehicles[0].Id.should.be.equal("id")
            done()
            return
        )

    it 'createVehicle should get create a firefly vehicle', (done) ->
        (createVehicle!=null).should.be.true
        Vehicle.prototype.save = (callback) ->
            console.log("save vehicle")
            callback(null)
            this._doc._id = 'vehicleId'

        createVehicle(results, (error, result) ->
            vehicle = results.vehicles[0]
            vehicle.Id.should.be.equal("vehicleId")
            done()
            return
        )

    it 'getMojioVehicle should return no mojio vehicle', (done) ->
        (getMojioVehicle!=null).should.be.true
        nock('https://staging-api.moj.io')
        .get("/v2/Vehicles")
        .reply((uri, requestBody, cb) ->
            cb(null, [200, JSON.stringify({Data: []})])
            return
        )
        getMojioVehicle(results, (error, result) ->
            results.mojioVehicles.length.should.be.equal(0)
            done()
            return
        )