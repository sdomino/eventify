gulp      = require 'gulp'

clean     = require 'gulp-clean'
coffee    = require 'gulp-coffee'
gutil     = require 'gulp-util'
rename    = require 'gulp-rename'
uglify    = require 'gulp-uglify'

#
_scripts = () ->
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
    )

#
_watch = () ->
  gulp.watch "./src/*.coffee", -> _scripts()

## tasks
gulp.task 'compile', () -> _scripts()
gulp.task 'default', [ 'compile' ], -> _watch()
