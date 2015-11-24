proxyquire = require('proxyquire')
pathStub   =  { }
config = require('../config/config')
mongoose = require('mongoose');
mongoose.connect(config.db)

should = require('should')
assert = require('chai').assert
expect = require('chai').expect
express = require('express')
nock = require('nock')

Vehicle = require('../models/firefly/Vehicle').model
app = express()
[getToken, getMe, getVehicle, getMojioVehicle, createVehicle] = require('../src/auth')(app)
MojioSDK = require 'mojio-js-sdk'

describe 'Authorization Tests', ->
    token = {access_token: 'token'}
    results = {token: token}
    user = null
    mojio = null
    vehicle = null
    client_id = 'cacc0d94-b6b4-4da7-9983-3991de197038'
    client_secret = '427d5794-5021-4274-a6e8-a38d5d83bf99'
    call = null
    timeout = 50
    callback_url = "http://localhost:3000/callback"
    authorization = {
        client_id: client_id,
        client_secret: client_secret
        redirect_uri: 'http://localhost:3000/callback'
        username: 'ashisha@moj.io'
        password: 'Test123'
        scope: 'full'
        grant_type: 'password'
    }
    options = {
        environment: 'staging'
        accountsURL: 'accounts.moj.io'
        apiURL: 'api.moj.io'
        pushURL: 'push.moj.io'
        client_id: authorization.client_id,
        client_secret: authorization.client_secret,
#        styles: [MojioPromiseStyle]

    }
    sdk = new MojioSDK(options)

    before (done) ->
        sdk
        .token(authorization.redirect_uri)
        .credentials(authorization.username, authorization.password)
        .scope(['full'])
        .callback((error, result) ->
            if (error)
                console.log('Access Token Error'+"  url:"+sdk.url())
                done(error, result)
            else
                sdk.token().parse(result).callback((error, result) ->
                    token = result
                    done(error, result)
                )
        )

    it 'getToken should get a token', (done) ->
        (getToken!=null).should.be.true

        getToken(token.access_token, (error, result) ->
            result.token.access_token.should.be.equal(token.access_token)
            done()
            return
        )

    it 'getMe should get a user', (done) ->
        (getMe!=null).should.be.true

        getMe(results, (error, result) ->
            (results.mojioUser.Id != null).should.be.true
            done()
            return
        )

    it 'getVehicle should get a firefly vehicle-user object', (done) ->
        (getVehicle!=null).should.be.true
        (results.mojioUser.Id!=null).should.be.true

        getVehicle(results, (error, result) ->
            (result!=null).should.be.true
            done()
            return
        )

    it 'getMojioVehicle should get a mojio vehicle', (done) ->
        (getMojioVehicle!=null).should.be.true

        getMojioVehicle(results, (error, result) ->
            (results.mojioVehicles[0].Id != null).should.be.true
            done()
            return
        )

    it 'createVehicle should get create a firefly vehicle', (done) ->
        (createVehicle!=null).should.be.true
#        Vehicle.prototype.save = (callback) ->
#            console.log("save vehicle")
#            callback(null)
#            this._doc._id = 'vehicleId'

        createVehicle(results, (error, result) ->
            (result.vehicles[0] != null).should.be.true
            done()
            return
        )