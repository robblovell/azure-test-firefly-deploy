Mongoose = require('mongoose')
Schema = Mongoose.Schema
require('mongoose-schema-extend')
ObjectId = Mongoose.Schema.Types.ObjectId

SendableSchema = require('./Sendable').schema

AdviceSchema = SendableSchema.extend({
})

MaintenanceSchema = SendableSchema.extend({
    advice: [AdviceSchema]
    completed: { type: Date, default: null}
    vehicle: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'Vehicle'
        index: true
        require: true
        unique: false
    }
})

TaskSchema = MaintenanceSchema.extend({

})
ServiceItemSchema = MaintenanceSchema.extend({
    tasks: [TaskSchema]
    offers: [{ type: Mongoose.Schema.Types.ObjectId, ref: 'Offer' }]
    servicetemplate: {
        type: Mongoose.Schema.Types.ObjectId
        ref: 'ServiceTemplate'
        index: false
        require: false
        unique: false
    }
})

module.exports = { model: Mongoose.model("ServiceItem", ServiceItemSchema), schema: ServiceItemSchema }