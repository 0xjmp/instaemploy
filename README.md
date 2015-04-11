Instaemploy
============

## Prerequisites
[Install Ruby on Mac]

Make sure you have redis installed
```
brew install redis
```

### Installation
```
git clone git@github.com:Instaemploy/instaemploy.git
cd instaemploy
bundle
bundle exec rake db:create
bundle exec db:schema:load
bundle exec db:migrate
bundle exec bower:install
foreman start
```

### Deployments
- [Install VirtualBox]
- [Install Vagrant]
```
vagrant box add ubuntu http://files.vagrantup.com/precise32.box
vagrant up
```
All scripts need to be in [Ansible].

### Testing
The most efficient way to run the testing suite is with guard:
```
bundle exec guard start
```
## Manual test commands
To test the api server endpoints:
```
rspec spec/
```
To run JavaScript tests:
```
rake teaspoon
```
To run JavaScript E2E tests:
```
rspec spec/features
```

### Problems?
#### No environment variables? 
You need to create your own .env files and then [Install autoenv].

Is the database setup?
```
bin/rake db:drop && bin/rake db:schema:dump && bin/rake db:create && bin/rake app:setup
```

[Install Ruby on Mac]:http://railsapps.github.io/installrubyonrails-mac.html
[Install autoenv]:https://github.com/kennethreitz/autoenv
[Install VirtualBox]:https://www.virtualbox.org/wiki/Downloads
[Install Vagrant]:http://www.vagrantup.com/downloads
[Ansible]:http://www.ansible.com/home