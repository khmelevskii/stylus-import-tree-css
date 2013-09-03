module.exports = (grunt) ->
  grunt.initConfig
    nodeunit:
      files: ['test/test.coffee']

    stylus:
      test:
        options:
          compress: false
          paths: ['test/fixtures']
          define:
            import_tree: require './index'
        files:
          'tmp/app.css': ['test/fixtures/app.styl']

    clean:
      test: ['tmp/']

  grunt.registerTask 'logcontent', ->
    console.log grunt.file.read 'tmp/app.css'

  # Load installed tasks
  grunt.file.glob
  .sync('./node_modules/grunt-*/tasks')
  .forEach(grunt.loadTasks)

  # Shortcuts
  grunt.registerTask 'test', ['clean', 'stylus', 'nodeunit']
  grunt.registerTask 'demo', ['clean', 'stylus', 'logcontent']

  # Default task
  grunt.registerTask 'default', 'test'
