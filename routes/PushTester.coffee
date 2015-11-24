module.exports = (app) ->
# Create the REST resource.
    return app.post('/push', (req, res) ->
        console.log("Message: "+req.body.message)
        res.json({ok: true, message: req.body.message})
    )
