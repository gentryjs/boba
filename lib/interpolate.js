const template = require('lodash.template')

module.exports = function (tmpl, sandbox) {
  if (sandbox === null) {
    sandbox = {}
  }
  if (!tmpl) {
    return ''
  }
  tmpl = template(tmpl)
  return tmpl(sandbox)
}
