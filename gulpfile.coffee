# Gulp stuff.
gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
sourcemaps = require('gulp-sourcemaps')
touch = require('touch')
path = require('path')
tap = require('gulp-tap')
sh = require('shelljs')
parallelize = require("concurrent-transform")
coffeeFiles = ['./*.coffee','./src/**/*.coffee','./routes/**/*.coffee','./test/**/*.coffee','./unittest/**/*.coffee','./test/**/*.coffee','./models/**/*.coffee','./controllers/**/*.coffee','./bin/**/*.coffee','./node-red/**/*.coffee',]
jadeFiles = ['./views/*.jade']
threads = 100
useSourceMaps = true

handleError = (err) ->
    console.log(err.toString())
    @emit('end')

gulp.task('touch', () ->
    gulp.src(coffeeFiles)
    .pipe(
        tap((file, t) ->
            touch(file.path)
        )
    )
    gulp.src(jadeFiles)
    .pipe(
        tap((file, t) ->
            touch(file.path)
        )
    )
)

gulp.task('coffeescripts', () ->
    gulp.src(coffeeFiles)
    .pipe(parallelize(coffee({bare: true}).on('error', gutil.log), threads))
    .pipe(parallelize((if useSourceMaps then sourcemaps.init() else gutil.noop()), threads))
)

gulp.task('watch', () ->
    gulp.watch(coffeeFiles, ['coffeescripts'])
    gulp.watch(paths.sass, ['sass'])
)

gulp.task('default', ['watch', 'coffeescripts'])

gulp.task('done', (() -> ))
