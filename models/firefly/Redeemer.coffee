Mongoose = require('mongoose')
Schema = require('mongoose').Schema
ObjectId = require('mongoose').Schema.Types.ObjectId
RedeemerSchema = new Schema({
    name: String
    address: String
    phone: String
    email: String
    artwork: String
    icon: String
})
module.exports = { model: null, schema: RedeemerSchema }
