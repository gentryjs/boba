fission = require './app'
IndexView = require './pages/Index/Index.View'
ModelView = require './pages/Index/Model.View'

NotFoundView = require './pages/NotFound/NotFound.View'

fission.router.route '/',
  title: "Todos"
  view: IndexView
  el: 'content'
  continue: false

fission.router.route '/todo/:todo',
  title: "Standalone"
  view: ModelView
  el: 'content'
  continue: false

fission.router.route '*',
  title: "Not Found"
  view: NotFoundView
  el: 'content'
  continue: false

fission.router.start()
