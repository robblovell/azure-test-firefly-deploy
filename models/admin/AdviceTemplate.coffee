Mongoose = require('mongoose')
require('mongoose-schema-extend')
ObjectId = Mongoose.Schema.Types.ObjectId
TriggerableSchema = require('./Triggerable').schema

AdviceTemplateSchema = TriggerableSchema.extend({

})
module.exports = { model: Mongoose.model("Advice", AdviceTemplateSchema), schema: AdviceTemplateSchema }