
all: .drone.yml.sig

.drone.yml.sig: .drone.yml
	drone sign ddriddle/elastic_beanstalk_demo
