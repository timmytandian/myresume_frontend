import gulp from "gulp";
import htmlhint from 'gulp-htmlhint';

// Validate the HTML
gulp.task('html', function(){
    return gulp.src('src/index.html')
        .pipe(htmlhint())
        .pipe(htmlhint.failAfterError());
});

// Define the default task
gulp.task("default", gulp.series("html"));