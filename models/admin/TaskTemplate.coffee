Mongoose = require('mongoose')
require('mongoose-schema-extend')
MaintenanceSchema = require('./Maintenance').schema

TaskTemplateSchema = MaintenanceSchema.extend({

})
module.exports = { model: Mongoose.model("Task", TaskTemplateSchema), schema: TaskTemplateSchema }