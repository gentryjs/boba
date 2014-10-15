module.exports = (blacklist, file) ->
  for pattern in blacklist
    if pattern instanceof RegExp
      return false if pattern.test file 
    else if typeof(pattern) is 'string'
      return false if pattern is file
  return true   