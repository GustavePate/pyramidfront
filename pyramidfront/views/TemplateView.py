from pyramid.view import view_config
from pyramid.response import Response


@view_config(route_name='template', renderer='../templates/mytemplate.pt')
class MyView(object):

    def __init__(self, request):
        self.request = request

    def __call__(self):

        return {'project': 'Iamaclass'}
        #return Response('hello')
