from pyramid.view import view_config


@view_config(route_name='arg', renderer='../templates/mytemplate.pt')
def my_view(request):
        return {'project': 'Arrgghh!'}
