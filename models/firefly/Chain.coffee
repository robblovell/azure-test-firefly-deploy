Mongoose = require('mongoose')
require('mongoose-schema-extend')
ObjectId = Mongoose.Schema.Types.ObjectId
RedeemerSchema = require('./Redeemer').schema

ChainSchema = RedeemerSchema.extend({
    dealers : [{ type: Mongoose.Schema.Types.ObjectId, ref: 'Dealer' }]
})
module.exports = { model: Mongoose.model("Chain", ChainSchema), schema: ChainSchema }