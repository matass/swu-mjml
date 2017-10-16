var gulp = require('gulp'),
  mocha  = require('gulp-mocha'),
  babel  = require('babel-register');

gulp.task('test', function() {
  return gulp.src('test/test.coffee')
    .pipe(mocha({
      compilers:babel
  }));
});
