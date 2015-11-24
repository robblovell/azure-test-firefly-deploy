Mongoose = require('mongoose')
require('mongoose-schema-extend')
ObjectId = Mongoose.Schema.Types.ObjectId

RedeemerSchema = require('./Redeemer').schema

DealerSchema = RedeemerSchema.extend({
    lat: String
    lon: String
    MojioUserId: String
    MojioGroupId: String
    chain: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'Chain'
        index: true
        require: true
    }
})
DealerModel = Mongoose.model("Dealer", DealerSchema)
module.exports = { model: DealerModel, schema: DealerSchema }