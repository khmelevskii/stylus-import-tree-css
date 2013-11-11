###!
Licensed under the MIT license.
###

fs = require 'fs'
path = require 'path'
stylus = require 'stylus'
glob = require 'glob'
_ = require 'underscore'

getStylusFiles = (dir) ->
  glob.sync("#{dir}/**/*.styl")
  .map (item) -> # https://github.com/isaacs/node-glob/issues/74
    path.resolve item

getImportNodesFromFile = (filename) ->
  expr = new stylus.nodes.Expression()
  strNode = new stylus.nodes.String filename
  expr.push strNode
  importExpr = new stylus.nodes.Import expr
  @visitImport(importExpr).nodes

getImportNodesFromDir = (dir) ->
  _(getStylusFiles dir)
  .chain()
  .map(getImportNodesFromFile.bind @)
  .flatten()
  .unshift(stylus.nodes['null'])
  .value()

getImportNodes = (filepath) ->
  method = if fs.statSync(filepath).isDirectory() then getImportNodesFromDir else getImportNodesFromFile
  method.call @, filepath

module.exports = (expr) ->
  filepath = path.resolve path.dirname(@filename), expr.val
  nodes = getImportNodes.call @, filepath

  @mixin nodes, @currentBlock
  nodes
