from pyramid.config import Configurator


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    route MUST have a view className
    """
    config = Configurator(settings=settings)
    config.include('pyramid_chameleon')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('template', '/template')
    config.add_route('arg', '/arg')
    config.add_route('FoodSearch', '/foodsearch')
    config.scan()
    return config.make_wsgi_app()
