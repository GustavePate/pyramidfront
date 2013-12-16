PYTHON=`which python`
PROTOC=`which protoc`
NAME=`python setup.py --name`
VERSION=`python setup.py --version`
SDIST=dist/$(NAME)-$(VERSION).tar.gz
VENV=/tmp/venv
PROJECT_PATH=/home/project/git/front/env/pyramidfront

PROTOPATH=./pyramidfront/ressources/commons/protos
PROTOPYPATH=./pyramidfront/pyfront/commons/protos/

#PYTHON PATH MODIFICATION SHALL BE COPIED TO TRAVIS.YML !!! 
PROTOC_PY_PATH=${PWD}/$(PROTOPYPATH)
PYTHONPATH := ${PYTHONPATH}:$(PROTOC_PY_PATH)
##############################
#  my targets
##############################

indent:
	$(PYTHON) -m reindent --nobackup *.py

initdep:
	$(PYTHON) setup.py develop

test:
	$(PYTHON) setup.py test -q

clean:
	find . -type f -name "*.pyc" -exec rm -f {} \;

apply:
	touch $(PROJECT_PATH)/../pyramid.wsgi

protoc:
	$(PROTOC) --python_out=$(PROTOPYPATH) --proto_path=$(PROTOPATH) $(PROTOPATH)/objects/*
	$(PROTOC) --python_out=$(PROTOPYPATH) --proto_path=$(PROTOPATH) $(PROTOPATH)/services/*
	$(PROTOC) --python_out=$(PROTOPYPATH) --proto_path=$(PROTOPATH) $(PROTOPATH)/generic_service.proto


##############################
#  obsolete targets
##############################
# replaced by apache2
#serve:
#	pserve development.ini --reload


##############################
# original targets
############################## 
all: check test source deb

dist: source deb

source:
	$(PYTHON) setup.py sdist

deb:
	$(PYTHON) setup.py --command-packages=stdeb.command bdist_deb

rpm:
	$(PYTHON) setup.py bdist_rpm --post-install=rpm/postinstall --pre-uninstall=rpm/preuninstall

install:
	$(PYTHON) setup.py install --install-layout=deb


check:
	find . -name \*.py | grep -v "^test_" | xargs pylint --errors-only --reports=n
	# pep8
	# pyntch
	# pyflakes
	# pychecker
	# pymetrics

upload:
	$(PYTHON) setup.py sdist register upload
	$(PYTHON) setup.py bdist_wininst upload

init:
	pip install -r requirements.txt --use-mirrors

update:
	rm ez_setup.py
	#wget http://peak.telecommunity.com/dist/ez_setup.py

daily:
	$(PYTHON) setup.py bdist egg_info --tag-date

deploy:
	# make sdist
	rm -rf dist
	python setup.py sdist

	# setup venv
	rm -rf $(VENV)
	virtualenv --no-site-packages $(VENV)
	$(VENV)/bin/pip install $(SDIST)

original_(added)__clean:
	$(PYTHON) setup.py clean
	rm -rf build/ MANIFEST dist build my_program.egg-info deb_dist
	find . -name '*.pyc' -delete

