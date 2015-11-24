Mongoose = require('mongoose')
Schema = require('mongoose').Schema
ObjectId = require('mongoose').Schema.Types.ObjectId
MojioVehicleSchema = new Schema({
    vehicleId: String #mojio Vehicle Id.
    serviceTemplateId: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'ServiceTemplate',
        index: true
        require: true
    }
})
module.exports = { model: Mongoose.model("MojioVehicle", MojioVehicleSchema), schema: MojioVehicleSchema }
