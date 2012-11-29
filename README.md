Dashku
===

![Dashku Screenshot](https://raw.github.com/Anephenix/dashku/master/dashku-screenshot.png)

Introduction
---

Dashku is a web application for creating dashboards and widgets in HTML, CSS, and JavaScript. It is open source, and available to download from Github. There is also a [hosted edition at Dashku.com](https://dashku.com).

Dependencies
---

- Node.js (0.8)
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
    node_modules/.bin/coffee app.coffee

Seeding the database with widget templates
---

You can seed Dashku's database with widget templates by running this command:

    node_modules/.bin/cake populateWidgetTemplates

Using Dashku to create dashboards and widgets
---

Documentation will be coming soon.

Testing
---

To run unit and functional tests:

    node_modules/.bin/cake test

To run the integration tests:

    node_modules/.bin/cucumber.js

License & Credits
---

&copy; 2012 Anephenix Ltd. The Nike swoosh is a registered trademark of Nike Inc.

Dashku is licensed under the [MIT license](www.opensource.org/licenses/MIT)