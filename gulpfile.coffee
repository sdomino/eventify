gulp      = require 'gulp'

bump      = require 'gulp-bump'
clean     = require 'gulp-clean'
coffee    = require 'gulp-coffee'
fs        = require 'fs'
gutil     = require 'gulp-util'
rename    = require 'gulp-rename'
uglify    = require 'gulp-uglify'

version = undefined

#
_scripts = () ->
  _version ( ->
    gulp.src("./dist/*.js", { read: false })
      .pipe( clean({ force: true }),
        gulp.src([ "./src/*.coffee" ])
          .pipe( coffee({ bare: true }).on('error', gutil.log) ).on('error', gutil.beep)

          # src (unminified and unversioned)
          .pipe( gulp.dest('./src') )

          # dist
          .pipe( uglify() )

          # minified unversioned
          .pipe( rename({ suffix: ".min" }) )
          .pipe( gulp.dest('./dist') )

          # minified versioned
          .pipe( rename({ suffix: ".#{version}.min" }) )
          .pipe( gulp.dest('./dist') )
      )
    )

#
_bump = (type) ->
  gulp.src('./package.json')
    .pipe(bump({ type: type || 'patch' }))
    .pipe(gulp.dest('./'))

#
_version = (cb) ->
  fs.readFile './package.json', (err, data) ->
    return console.log "Unable to read package.json :: #{err}" if err

    version = JSON.parse(data).version

    return cb()

#
_watch = () ->
  gulp.watch "./src/*.coffee", -> _scripts()


## tasks
gulp.task 'bump', () -> _bump(gulp.env.type)
gulp.task 'compile', () -> _scripts()

gulp.task 'default', [ 'compile' ], -> _watch()
