// Generated by CoffeeScript 1.10.0
(function() {
  var Mongoose, ObjectId, ReasonSchema, Schema;

  Mongoose = require('mongoose');

  Schema = require('mongoose').Schema;

  ObjectId = Mongoose.Schema.Types.ObjectId;

  ReasonSchema = new Schema({
    name: String,
    source: String,
    property: String,
    condition: String,
    situation: ObjectId
  });

  module.exports = {
    model: Mongoose.model("Reason", ReasonSchema),
    schema: ReasonSchema
  };

}).call(this);

//# sourceMappingURL=Reason.js.map
