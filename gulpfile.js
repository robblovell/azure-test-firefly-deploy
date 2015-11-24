// Generated by CoffeeScript 1.10.0
(function() {
  var coffee, coffeeFiles, gulp, gutil, handleError, jadeFiles, parallelize, path, sh, sourcemaps, tap, threads, touch, useSourceMaps;

  gulp = require('gulp');

  gutil = require('gulp-util');

  coffee = require('gulp-coffee');

  sourcemaps = require('gulp-sourcemaps');

  touch = require('touch');

  path = require('path');

  tap = require('gulp-tap');

  sh = require('shelljs');

  parallelize = require("concurrent-transform");

  coffeeFiles = ['./*.coffee', './src/**/*.coffee', './routes/**/*.coffee', './test/**/*.coffee', './unittest/**/*.coffee', './test/**/*.coffee', './models/**/*.coffee', './controllers/**/*.coffee', './bin/**/*.coffee', './node-red/**/*.coffee'];

  jadeFiles = ['./views/*.jade'];

  threads = 100;

  useSourceMaps = true;

  handleError = function(err) {
    console.log(err.toString());
    return this.emit('end');
  };

  gulp.task('touch', function() {
    gulp.src(coffeeFiles).pipe(tap(function(file, t) {
      return touch(file.path);
    }));
    return gulp.src(jadeFiles).pipe(tap(function(file, t) {
      return touch(file.path);
    }));
  });

  gulp.task('coffeescripts', function() {
    return gulp.src(coffeeFiles).pipe(parallelize(coffee({
      bare: true
    }).on('error', gutil.log), threads)).pipe(parallelize((useSourceMaps ? sourcemaps.init() : gutil.noop()), threads));
  });

  gulp.task('watch', function() {
    gulp.watch(coffeeFiles, ['coffeescripts']);
    return gulp.watch(paths.sass, ['sass']);
  });

  gulp.task('default', ['watch', 'coffeescripts']);

  gulp.task('done', (function() {}));

}).call(this);

//# sourceMappingURL=gulpfile.js.map