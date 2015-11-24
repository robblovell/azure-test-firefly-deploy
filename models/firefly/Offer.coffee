Mongoose = require('mongoose')
ObjectId = Mongoose.Schema.Types.ObjectId
require('mongoose-schema-extend')
SendableSchema = require('./Sendable').schema

OfferSchema = SendableSchema.extend({
    discounttype: String
    discountamount: String
    expires: Date
    redeemed: Date
    serviceitem: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'ServiceItem',
        index: true
        require: true
    }
    vehicle: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'Vehicle',
        index: true
        require: true
    }
    redemptions: [{ type: Mongoose.Schema.Types.ObjectId, ref: 'Redemption' }]

})
module.exports = { model: Mongoose.model("Offer", OfferSchema), schema: OfferSchema }
