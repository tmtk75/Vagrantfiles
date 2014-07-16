jarfile = ee-datasets/elastic-loader.jar
es_host = http://localhost:9200 
datasets_dir = ee-datasets/datasets

usage:
	echo Hi!

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

