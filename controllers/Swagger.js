// Generated by CoffeeScript 1.10.0
(function() {
  var _;

  _ = require('lodash');

  module.exports = function(app, resources, spec, config) {
    var definitions, paths, specification;
    if (spec == null) {
      spec = '/spec';
    }
    paths = {};
    definitions = {};
    _.each(resources, function(resource) {
      var swagger;
      swagger = resource.swagger();
      paths = _.assign(paths, swagger.paths);
      return definitions = _.assign(definitions, swagger.definitions);
    });
    specification = {
      swagger: '2.0',
      info: {
        description: 'description here',
        version: config.version,
        title: 'Mojio FireFly API',
        contact: {
          name: 'Mojio'
        }
      },
      host: config.host,
      basePath: config.basepath,
      schemes: [config.scheme],
      definitions: definitions,
      paths: paths
    };
    return app.get(spec, function(req, res, next) {
      return res.json(specification);
    });
  };

}).call(this);

//# sourceMappingURL=Swagger.js.map
