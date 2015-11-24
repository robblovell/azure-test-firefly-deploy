Mongoose = require('mongoose')
Schema = require('mongoose').Schema
ObjectId = require('mongoose').Schema.Types.ObjectId
EventSchema = require('./../firefly/Event').schema
SituationSchema = new Schema({
    name: String
    events: [EventSchema]
    Debounce: String
    Throttle: String
    Timing: String
    State: Boolean
})
module.exports = { model: Mongoose.model("Situation", SituationSchema), schema: SituationSchema }
