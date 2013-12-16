from pyramid.view import view_config
from pyramid.response import Response


@view_config(route_name='FoodSearch', renderer='json')
class MyView(object):

    pattern = ""

    def __init__(self, request):
        #self.pattern = request.params['pattern']
        self.request = request
        print self.request
        #print self.request.body
        print self.request.params
        #print self.request.json
        if 'pattern' in self.request.params.keys():
            print self.request.params['pattern']

    def __call__(self):

        #return {'project': 'Iamaclass'}
        return {'hello:':'hjkl'}
