/*!
Licensed under the MIT license.
*/

var fs, getImportNodes, getImportNodesFromDir, getImportNodesFromFile, getStylusFiles, glob, path, stylus, _;

fs = require('fs');

path = require('path');

stylus = require('stylus');

glob = require('glob');

_ = require('underscore');

getStylusFiles = function(dir) {
  return glob.sync("" + dir + "/**/*.styl").map(function(item) {
    return path.resolve(item);
  });
};

getImportNodesFromFile = function(filename) {
  var expr, importExpr, strNode;
  expr = new stylus.nodes.Expression();
  strNode = new stylus.nodes.String(filename);
  expr.push(strNode);
  importExpr = new stylus.nodes.Import(expr);
  return this.visitImport(importExpr).nodes;
};

getImportNodesFromDir = function(dir) {
  return _(getStylusFiles(dir)).chain().map(getImportNodesFromFile.bind(this)).flatten().unshift(stylus.nodes['null']).value();
};

getImportNodes = function(filepath) {
  var method;
  method = fs.statSync(filepath).isDirectory() ? getImportNodesFromDir : getImportNodesFromFile;
  return method.call(this, filepath);
};

module.exports = function(expr) {
  var filepath, nodes;
  filepath = path.resolve(path.dirname(this.filename), expr.val);
  nodes = getImportNodes.call(this, filepath);
  this.mixin(nodes, this.currentBlock);
  return nodes;
};
