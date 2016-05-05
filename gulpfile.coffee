gulp      = require 'gulp'
clean     = require 'gulp-clean'
coffee    = require 'gulp-coffee'
gutil     = require 'gulp-util'
jade      = require 'gulp-jade'
prettify  = require 'gulp-prettify'
rename    = require 'gulp-rename'
uglify    = require 'gulp-uglify'

#
_markup = () ->
  gulp.src("./stage/index.html", { read: false })
    .pipe( clean({ force: true }),
      gulp.src('./stage/index.jade')
        .pipe( jade() )
        .pipe( prettify() )
        .pipe( gulp.dest('./stage') )
    )

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
  gulp.watch "./stage/*.jade", -> _markup()
  gulp.watch "./src/*.coffee", -> _scripts()

## tasks
gulp.task 'compile', () -> _markup(); _scripts()
gulp.task 'default', ['compile'], -> _watch()
