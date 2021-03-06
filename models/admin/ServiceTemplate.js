// Generated by CoffeeScript 1.10.0
(function() {
  var MaintenanceSchema, Mongoose, ObjectId, Schema, ServiceTemplateSchema, TaskTemplateSchema;

  Mongoose = require('mongoose');

  require('mongoose-schema-extend');

  ObjectId = Mongoose.Schema.Types.ObjectId;

  Schema = require('mongoose').Schema;

  MaintenanceSchema = require('./Maintenance').schema;

  TaskTemplateSchema = require('./TaskTemplate').schema;

  ServiceTemplateSchema = MaintenanceSchema.extend({
    tasks: [TaskTemplateSchema]
  });

  module.exports = {
    model: Mongoose.model("ServiceTemplate", ServiceTemplateSchema),
    schema: ServiceTemplateSchema
  };

}).call(this);

//# sourceMappingURL=ServiceTemplate.js.map
