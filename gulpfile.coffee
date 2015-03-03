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

gulp.task 'configDev', () ->
  gulp.src 'public/config/config.dev.js'
  .pipe($.rename('config.js'))
  .pipe(gulp.dest('public/app/'))

gulp.task 'configRelease', () ->
  gulp.src 'public/config/config.release.js'
  .pipe $.rename('config.js')
  .pipe gulp.dest('public/app/')

gulp.task 'build', (done) ->
  runSequence 'cleanJsFolder', 'compilecoffee', 'configDev', done
  return

gulp.task 'release', (done) ->
  runSequence 'cleanJsFolder', 'compilecoffee', 'configRelease', 'package', done
  return

gulp.task 'package', (done) ->
  clean 'release.zip', done
  sourceGlob = [
    './api/*.*',
    './public/app/*.*',
    './public/css/*.*',
    './public/assets/*.*',
    './public/partials/*.*',
    './public/index.html',
    './.bowerrc',
    './bower.json',
    './gulpfile.*',
    './package.json',
    './server.*'
  ]
  gulp.src sourceGlob, { base: __dirname }
  .pipe $.zip 'release.zip'
  .pipe gulp.dest __dirname
  return


gulp.task 'server', ['build'], () ->
  if node?
    node.kill()

  node = spawn 'node', ['server.js'], { stdio: 'inherit' }
  node.on 'close', (code) ->
    if code is 8
      console.log 'Error detected, waiting for changes..'
  return

gulp.task 'help', () ->
  console.log '##############################################'
  console.log 'gulp serve -- to run a dev server with watch'
  console.log 'gulp release -- to build a release version of the app as a compressed file'
  console.log '##############################################'

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

