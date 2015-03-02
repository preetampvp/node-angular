gulp = require 'gulp'
$ = require('gulp-load-plugins')({ lazy:true })
runSequence = require 'run-sequence'
del = require('del')

gulp.task 'compilecoffee', () ->
  console.log 'Converting .coffee --> .js'

  gulp.src('public/app-coffee/**/*.coffee')
  .pipe($.coffee({bare: true}).on('error', $.util.log))
  .pipe(gulp.dest('public/app/'))

gulp.task 'cleanJsFolder', (done) ->
  clean './public/app', done

gulp.task 'build', (done) ->
  runSequence 'cleanJsFolder', 'compilecoffee', done
  return

##################################
clean = (path, done) ->
  console.log "Cleaning #{path}"
  del path, done
  return

