config =
    env: process.env.NODE_ENV || 'local'
    db: process.env.DB || "mongodb://localhost:27017"
    port: process.env.PORT || '3000'
    host: process.env.HOST || 'localhost'
    basepath: "/"
    scheme: process.env.SCHEME || 'https'
    insightsKey: ""
    segementKey: ""
    version: "0.0.30"

switch config.env
    # todo:: develop and staging databases
    when 'develop'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = "devapifireflywebmojious.azurewebsites.net"
        config.schemes = ['http']
    when 'staging'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = "stageapifireflywebmojious.azurewebsites.net"
        config.schemes = ['https']
    when 'production'
        config.db = process.env.DB
        config.basepath = "/"
        config.host = "prodapifireflywebmojious.azurewebsites.net"
        config.schemes = ['https']
    else
        config.db = "mongodb://localhost:27017"
        config.basepath = "/"
        config.host = "localhost:3000"
        config.schemes = ['http']

console.log("configuration: "+JSON.stringify(config))
module.exports = config
