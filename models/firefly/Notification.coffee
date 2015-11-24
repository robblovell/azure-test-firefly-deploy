Mongoose = require('mongoose')
require('mongoose-schema-extend')

Schema = Mongoose.Schema

NotificationSchema = new Schema(
    {
        message: String
        token: String
    }
)

module.exports = { model: Mongoose.model("Notification", NotificationSchema), schema: NotificationSchema }
