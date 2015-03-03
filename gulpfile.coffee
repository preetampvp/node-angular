gulp = require 'gulp'
$ = require('gulp-load-plugins')({ lazy:true })
runSequence = require 'run-sequence'
del = require 'del'
spawn = require('child_process').spawn
node = null

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

gulp.task 'server', ['build'], () ->
  if node?
    node.kill()

  node = spawn 'node', ['server.js'], { stdio: 'inherit'}
  node.on 'close', (code) ->
    if code is 8
      console.log 'Error detected, waiting for changes..'
  return

process.on 'exit', () ->
  if node?
    node.kill()
  return

gulp.task 'serve', () ->
  gulp.run 'server'
  gulp.watch ['./public/**/*.coffee', './api/**/*.coffee'], () ->
    gulp.run 'server'




##################################
clean = (path, done) ->
  console.log "Cleaning #{path}"
  del path, done
  return

