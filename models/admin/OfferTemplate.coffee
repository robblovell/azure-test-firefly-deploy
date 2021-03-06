Mongoose = require('mongoose')
ObjectId = Mongoose.Schema.Types.ObjectId
TriggerableSchema = require('./Triggerable').schema

OfferTemplateSchema = TriggerableSchema.extend({
    discount: { type: String, amount: Number },
    expires: Date
})
module.exports = { model: Mongoose.model("OfferTemplate", OfferTemplateSchema), schema: OfferTemplateSchema }
