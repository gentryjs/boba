isObjectId = require '../../lib/isObjectId'
db = require '../../db'
<%= model %> = db.model '<%= model %>'

module.exports = (req, res, next) ->
  return res.status(403).end() unless req.isAuthenticated()

  # return all
  q = <%= model %>.find()
  q.select '-token'
  q.limit 3

  q.exec (err, <%= model %>s) ->
    return next err if err?
    res.status(200).json <%= model %>s