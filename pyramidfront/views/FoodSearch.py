from pyramid.view import view_config
from pyfront.commons.protos.service import search_food_service_pb2


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

        return {'project': 'Iamaclass'}
        #resp = Response('toto')  #{'hello:':'hjkl'}
        #return resp
