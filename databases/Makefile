jarfile = ee-datasets/elastic-loader.jar
es_host = http://localhost:9200 
datasets_dir = ee-datasets/datasets

usage:
	@echo Hi!
	@echo vagrant up, and make import

#
# elasticsearch datasets
#
import: darwin-origin hacker_planet movie_db products products_multi_tagged usernames

darwin-origin: .darwin-origin
hacker_planet: .hacker_planet
movie_db: .movie_db
products: .products
products_multi_tagged: .products_multi_tagged
usernames: .usernames

.darwin-origin:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/darwin-origin.eloader
	touch $@

.hacker_planet:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/hacker_planet.eloader
	touch $@

.movie_db:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/movie_db.eloader
	touch $@

.products:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/products.eloader
	touch $@

.products_multi_tagged:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/products_multi_tagged.eloader
	touch $@

.usernames:
	java -jar $(jarfile) $(es_host) $(datasets_dir)/usernames.eloader
	touch $@

inquisitor:
	open http://localhost:9200/_plugin/inquisitor

head:
	open http://localhost:9200/_plugin/head

up:
	vagrant up --provision

#
# elasticsearch-dsl-py
#
.py:
	virtualenv .py

.env: .py
	echo "source .py/bin/activate" > .env

es-dsl: elasticsearch-dsl-py/dist/elasticsearch_dsl-0.0.1-py2.7.egg

elasticsearch-dsl-py/dist/elasticsearch_dsl-0.0.1-py2.7.egg: elasticsearch-dsl-py
	(cd elasticsearch-dsl-py; \
	git checkout 9b638a3e9ec3d2cf9de058068b861012614d4def; \
	python setup.py install)

elasticsearch-dsl-py:
	git clone git@github.com:elasticsearch/elasticsearch-dsl-py.git

