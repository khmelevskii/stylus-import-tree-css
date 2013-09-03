grunt = require 'grunt'

grunt.file.defaultEncoding = 'utf8'

module.exports =
  import_tree: (test) ->
    test.expect 1

    expected = grunt.file.read 'test/expected/app.css'
    actual = grunt.file.read 'tmp/app.css'

    test.equal actual, expected, 'should compile including entire specified directory tree'
    test.done()
