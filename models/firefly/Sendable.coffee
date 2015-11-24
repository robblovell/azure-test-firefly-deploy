Mongoose = require('mongoose')
Schema = require('mongoose').Schema
ObjectId = Mongoose.Schema.Types.ObjectId
ReasonSchema = require('./Reason').schema

SendableSchema = new Schema(
    {
        name: String
        description: String
        icon: String
        artwork: String
        tag: String
        given: { type: Date, default: Date.now }
        reasons: [ReasonSchema] # situations it was sent under.
        times: Number
        dismissed: { type: Date, default: null }
    }
)

module.exports = { model: null, schema: SendableSchema }