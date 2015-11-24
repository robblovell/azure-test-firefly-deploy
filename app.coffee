_ = require 'underscore'
express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
routes = require('./routes/index')
cors = require('cors')
app = express()

# view engine setup
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')

# uncomment after placing your favicon in /public
app.use(favicon(path.join(__dirname, 'public', 'favicon.png')))
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: false }))
app.use(cookieParser())
app.use(require('less-middleware')(path.join(__dirname, 'public')))
app.use(cors())
app.use(express.static(path.join(__dirname, 'public')))
require('./src/auth')(app)
app.use('/', routes)
config = require('./config/config')

mongoose = require('mongoose');
mongoose.connect(config.db) # connect to our database
require('mongoose-schema-extend')


offerModel = require('./models/firefly/Offer')
Offer = require('./controllers/firefly/Offer')(app, offerModel.model)

vehicleModel = require('./models/firefly/Vehicle')
Vehicle = require('./controllers/firefly/Vehicle')(app, vehicleModel.model)

chainModel = require('./models/firefly/Chain')
Chain = require('./controllers/firefly/Chain')(app, chainModel.model)
dealerModel = require('./models/firefly/Dealer')
Dealer = require('./controllers/firefly/Dealer')(app, dealerModel.model)
ChainDealer = require('./controllers/firefly/ChainDealer')(app, dealerModel.model)
redemptionModel = require('./models/firefly/Redemption')
Redemption = require('./controllers/firefly/Redemption')(app, redemptionModel.model)
serviceItemModel = require('./models/firefly/ServiceItem')
ServiceItem = require('./controllers/firefly/ServiceItem')(app, serviceItemModel.model)

VehicleServiceItem = require('./controllers/firefly/VehicleServiceItem')(app, serviceItemModel.model)
#VehicleOffer = require('./controllers/firefly/VehicleOffer')(app, offerModel.model)
ServiceItemOffer = require('./controllers/firefly/ServiceItemOffer')(app, offerModel.model)
OfferRedemption = require('./controllers/firefly/OfferRedemption')(app, redemptionModel.model)

InstanceResources = {
    ServiceItem: ServiceItem
    ServiceItemOffer: ServiceItemOffer
    Redemption: Redemption
    Offer: Offer
    OfferRedemption: OfferRedemption
    Chain: Chain
    Dealer: Dealer
    ChainDealer: ChainDealer
    Vehicle: Vehicle
#    VehicleOffer: VehicleOffer
    VehicleServiceItem: VehicleServiceItem

}

ServiceTemplateModel = require('./models/admin/ServiceTemplate')
ServiceTemplate = require('./controllers/admin/ServiceTemplate')(app, ServiceTemplateModel.model)
SituationModel = require('./models/admin/Situation')
Situation = require('./controllers/admin/Situation')(app, SituationModel.model)
#mojioVehicleModel = require('./models/admin/MojioVehicle')
ServiceTemplateMojioVehicle = require('./controllers/admin/ServiceTemplateMojioVehicle')(app, vehicleModel.model)

TemplateResources = {
    ServiceTemplate: ServiceTemplate
    Situation: Situation
    ServiceTemplateMojioVehicle: ServiceTemplateMojioVehicle
}
ApiResources = {}
ApiResources = _.extend(ApiResources, InstanceResources)
ApiResources = _.extend(ApiResources, TemplateResources)

swagger = require('./controllers/Swagger')(app, InstanceResources, '/firefly', config)
swagger = require('./controllers/Swagger')(app, TemplateResources, '/wizard', config)
swagger = require('./controllers/Swagger')(app, ApiResources, '/api', config)

# error handlers
if (app.get('env') == 'development' or app.get('env') == 'local')
    # development error handleripho
    # will print stacktrace
    app.use((err, req, res, next) ->
        if (err?)
            res.status(err.status || 500)
            res.render('error', {
                message: err.message,
                error: err
            })

    )
else
    # production error handler
    # no stacktraces leaked to user
    app.use((err, req, res, next) ->
        if (err?)
            res.status(err.status || 500)
            res.render('error', {
                message: err.message,
                error: {}
            })
    )

module.exports = app
