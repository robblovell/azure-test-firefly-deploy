Mongoose = require('mongoose')
require('mongoose-schema-extend')
ObjectId = Mongoose.Schema.Types.ObjectId
TriggerableSchema = require('./Triggerable').schema
AdviceTemplateSchema = require('./AdviceTemplate').schema
OfferTemplateSchema = require('./OfferTemplate').schema

MaintenanceSchema = TriggerableSchema.extend({
    advice: [AdviceTemplateSchema],
    offers: [OfferTemplateSchema]
})
module.exports = { model: null, schema: MaintenanceSchema }