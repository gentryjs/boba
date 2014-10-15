template = require 'lodash.template'

module.exports = (tmpl, sandbox={}) -> 
  
  return "" unless tmpl
  
  tmpl = template tmpl
  return tmpl sandbox