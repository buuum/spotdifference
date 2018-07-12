module.exports = (grunt) ->
  grunt.file.expand('node_modules/grunt-*/tasks').forEach grunt.loadTasks

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      app:
        files:
          'spotdifference/js/spotdifference.min.js': 'spotdifference/js/spotdifference.js'
          'spotdifference/js/arearesponsive.min.js': 'spotdifference/js/arearesponsive.js'

    coffee:
      compile:
        options:
          bare: true
        expand: true
        cwd: "src/coffee"
        src: "**/**/*.coffee"
        dest: "spotdifference/js"
        ext: '.js'

    cssmin:
      target:
        files:
          'spotdifference/css/main.css': 'src/css/app.css'

    compass:
      dist:
        options:
          sassDir: "src/sass"
          cssDir: "src/css"


  grunt.registerTask 'buildcoffee', 'Generamos Coffee', =>
    grunt.task.run ['coffee', 'uglify:app']
    return

  grunt.registerTask 'buildsass', 'Generamos SASS', =>
    grunt.task.run ['compass', 'cssmin']
    return