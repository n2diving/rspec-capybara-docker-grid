# A Dockerized Selenium Grid with RSpec and Capybara

I built this project to quickly provision an environment for running
UI tests against a dockerized app. It employs a dockerized [Selenium Grid](https://github.com/SeleniumHQ/selenium/wiki/Grid2), which yields a far more cost-effective CI solution compared to purchasing and maintaining *n* dedicated machines.

I've included bash scripts in the `/bin` directory as wrappers for the `docker-compose` commands. Hopefully, once you've completed the initial setup, you won't have to recall any docker commands. :smiley:

Both RSpec and Capybara are automatically provisioned in the `rspec` docker image. As usual, you can easily customize their configurations in `spec/spec_helper.rb`.

### Dependencies (Mac OSX)

1. [dinghy](https://github.com/codekitchen/dinghy)  <--- You'll love it!!

If you haven't already followed dinghy's advice by adding the specified environment variables to your `.bashrc` file or equivalent, you need to do that now.

You'll know everything is working when you execute these commands...
```sh 
$ dinghy up
$ dinghy status
```

... and you see this:
```sh
$ dinghy status
  VM: running
 NFS: running
FSEV: running
 DNS: running
HTTP: running

Your environment variables are already set correctly.
```

2. docker-compose: `$ brew install docker-compose`
3. a copy of this repo on your machine
4. a docker image of the app under test (optional if you want to skip ahead)

By default the project will use [a bare-bones Sinatra web app](https://github.com/mycargus/hello-docker-world) as the app under test, so if you'd like to see this project in action before adding your app, go ahead and skip to the ["How do I execute the tests?"](https://github.com/mycargus/docker-grid-rspec-capybara#how-do-i-execute-the-tests) section.

### Setup

Add the docker image of the app under test to the `docker-compose.yml` file. Be sure to define its virtual URL (a default is provided). For example:
``` 
web:
  image: app-under-test:latest
  environment:
    VIRTUAL_HOST: app.under.test
```

That was easy!

NOTE: `VIRTUAL_HOST` is your app's URL against which Capybara will execute the tests. It can be whatever you want. If you change it, be sure to also change the value of `APP_HOST` in the `rspec` image's docker-compose.yml configuration.

If you're not sure how to create or pull a docker image, I recommend working through the official Docker tutorial located on their website.

### How do I execute the tests?

Start dinghy if it isn't already running (you can check with `$ dinghy status`):
```sh
$ dinghy up
```

Start the Selenium hub, the app under test, RSpec+Capybara, and the Selenium browser nodes:
```sh
$ bin/start
```

Execute the tests:
```sh
$ bin/test
```

When you're done, stop and remove the docker containers:
```sh
$ bin/stop
```

### Can I view the Selenium grid console?

Yep! After having started the Selenium hub and nodes (`$ bin/start`), open a
browser and go to [http://selenium.hub.docker](http://selenium.hub.docker), then click the 'console' link.

### A test is failing. How do I debug it?

Start the Selenium hub, the quiz_web app, and the Selenium *debug* browser nodes:
```sh
$ bin/debug_start
```

View the chrome debug node via VNC (password: `secret`):
```sh
$ open vnc://node.chrome.debug.docker
```

or view the firefox debug node via VNC (password: `secret`):
```sh
$ open vnc://node.firefox.debug.docker
```

Next execute the tests against the debug nodes:
```sh
$ bin/test
```

Again, once you're finished:
```sh
$ bin/stop
```
