Schema = require('mongoose').Schema
TriggerableSchema = new Schema ({
    name: String
    description: String
    icon: String
    artwork: String
    tag: String
})
TriggerableSchema.index({ name: 1, type: -1 })

module.exports = { model: null, schema: TriggerableSchema }