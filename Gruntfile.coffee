module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      dist:
        files:
          'index.js': 'src/index.coffee'
        options:
          bare: true

    nodeunit:
      files: ['test/test.coffee']

    stylus:
      test:
        options:
          compress: false
          paths: ['test/fixtures']
          define:
            import_tree: require './src/index'
        files:
          'tmp/app.css': ['test/fixtures/app.styl']

    clean:
      test: ['tmp/']

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  # Shortcuts
  grunt.registerTask 'test', ['clean', 'stylus', 'nodeunit']
  grunt.registerTask 'demo', ['clean', 'stylus', 'logcontent']
  grunt.registerTask 'b', ['test', 'coffee']

  # Default task
  grunt.registerTask 'default', 'b'
