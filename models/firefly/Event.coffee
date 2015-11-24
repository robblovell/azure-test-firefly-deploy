Mongoose = require('mongoose')
Schema = require('mongoose').Schema

EventSchema = new Schema({
    Source: String
    Property: String
    Condition: String
    Debounce: String
    Throttle: String
    Timing: String
    State: Boolean
    Conjunction: String
})
module.exports = { model: Mongoose.model("Event", EventSchema), schema: EventSchema }