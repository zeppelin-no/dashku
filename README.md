[![Build Status](https://travis-ci.org/anephenix/dashku.svg)](https://travis-ci.org/anephenix/dashku)
[![Coverage Status](https://coveralls.io/repos/anephenix/dashku/badge.svg?branch=master)](https://coveralls.io/r/anephenix/dashku?branch=master)
[![Dependency Status](https://david-dm.org/anephenix/dashku.svg)](https://david-dm.org/anephenix/dashku)
[![Dev Dependency Status](https://david-dm.org/anephenix/dashku/dev-status.svg)](https://david-dm.org/anephenix/dashku#info=devDependencies)
[![Code Climate](https://codeclimate.com/github/Anephenix/dashku.svg)](https://codeclimate.com/github/Anephenix/dashku)
[![Gitter chat](https://badges.gitter.im/Anephenix/dashku.svg)](https://gitter.im/Anephenix/dashku)
[![Issue Stats](http://issuestats.com/github/Anephenix/dashku/badge/pr)](http://issuestats.com/github/Anephenix/dashku)
[![Issue Stats](http://issuestats.com/github/Anephenix/dashku/badge/issue)](http://issuestats.com/github/Anephenix/dashku)

Dashku (classic edition)
===

![Dashku Screenshot](https://raw.github.com/Anephenix/dashku/master/dashku-screenshot.png)

Introduction
---

Dashku is a web application for creating dashboards and widgets in HTML, CSS, and JavaScript. It is open source, and available to download from Github. There is also a [hosted edition at Dashku.com](https://dashku.com).

You can also deploy your own copy with Heroku's click-to-deploy button below:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://www.heroku.com/deploy/?template=https://github.com/anephenix/dashku)

Note: If you deploy to Heroku, you will want to enable these features in Heroku Labs for your app:
	
	heroku labs:enable http-session-affinity
	heroku labs:enable http-end-to-end-continue

This will ensure that the app's use of WebSockets will work smoothly

Dependencies
---

- Node.js (0.10)
- MongoDB
- Redis

Installation
---

    git clone git://github.com/Anephenix/dashku.git
    cd dashku
    npm install

Booting the application
---

    mongod &
    redis-server &
    npm start

Seeding the database with widget templates
---

You can seed Dashku's database with widget templates by running this command:

    npm run populateWidgetTemplates

Using Dashku to create dashboards and widgets
---

Documentation will be coming soon.

Testing
---

To run unit and functional tests:

    npm test

To run the integration tests:

    npm run cuke

License & Credits
---

&copy; 2015 Anephenix Ltd. The Nike swoosh is a registered trademark of Nike Inc. Dashku is a trademark of Anephenix Ltd, and dashku is licenced under the LGPLv3 license. See LICENSE for details.
