Mongoose = require('mongoose')
Schema = require('mongoose').Schema
ObjectId = require('mongoose').Schema.Types.ObjectId
require('mongoose-schema-extend')
VehicleBase = new Schema({
})
VehicleSchema = VehicleBase.extend({
    mojioVehicleId: { type:String, unique: true } #mojio Vehicle Id.
    token: String
    mojioUserId: { type:String, unique: false }
    dealer: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'Dealer',
        index: true,
        require: false
    }
    serviceitems : [{ type: Mongoose.Schema.Types.ObjectId, ref: 'ServiceItem', require: false }]
})
module.exports = { model: Mongoose.model("Vehicle", VehicleSchema), schema: VehicleSchema }
