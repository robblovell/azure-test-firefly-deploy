Mongoose = require('mongoose')
Schema = require('mongoose').Schema

RedemptionSchema = new Schema ({
    redeemed: Date
    lat: Number
    lon: Number
    value: Number
    offer: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'Offer',
        index: true
        require: true
    }
})

module.exports = { model: Mongoose.model("Redemption", RedemptionSchema), schema: RedemptionSchema }
