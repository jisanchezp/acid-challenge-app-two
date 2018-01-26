# Acid Challenge App Three

This application is the server side from a whole (basic) system. The complete
system has a client/server architecture, interconnected by a REST proxy API.
In this app, you will find an user manager system (List all, Create, Edit, Delete).
And an API which is requested by the client app through the proxy API, and
returns a response (status codes 200 & 401 only, plus a message).

**IMPORTANT:**

The followings steps, with the exception of **Prerequisites** and
**Running the tests**, are just for **Acid Challenge App Three**, for the other
applications you must follow their own steps specified in their Github pages.

### Prerequisites

Follow the steps of **1 Guide Assumptions** in [Ruby on Rails - Getting Started](http://guides.rubyonrails.org/getting_started.html) to install ruby on rails environment.

### Installing

To deploy the whole system, you have to clone these three applications.

* [acid-challenge-app-one](https://github.com/jisanchezp/acid-challenge-app-one) - Client app (instructions on it's GitHub Page)
* [acid-challenge-app-two](https://github.com/jisanchezp/acid-challenge-app-two) - Server app (this one)
* [acid-challenge-app-three](https://github.com/jisanchezp/acid-challenge-app-three) - Proxy app (instructions on it's GitHub Page)

1) Clone the project's repository to your local machine:

```
$ git clone https://github.com/jisanchezp/acid-challenge-app-two
```

2) Install all gems executing the following command inside project's main folder:

```
$ bundle install --without production
```

3) Create the following environment variable:

This project has Figaro gem installed.

Run this command, and it will create **config/application.yml** and will add it to git ignore.

```
$ bundle exec figaro install
create  config/application.yml
append  .gitignore
```

After this, copy/paste the following to the recently created **config/application.yml**.

```
SENDGRID_USERNAME: '<you-sendgrid-username>' # If you don't have SendGrid credentials
SENDGRID_PASSWORD: '<you-sendgrid-username>' # refer to the Deployment section

development:
  proxy_api_host: 'localhost' # This key help prevent POST requests to rest/verify from any other domain
  smtp_domain: 'localhost'

production:
  proxy_api_host: '<your-app-three-heroku-domain>'
  smtp_domain: '<your-app-two-heroku-domain>' # This key help prevent POST requests to rest/verify from any other domain
```

4) Start Rails server with port '3001':

```
$ rails s -p 3001
```

5) Open the [app](http://localhost:3001).

6) Add/list/edit/delete users and start receiving requests.

## Running the tests

To run automated tests follow the following steps:

Pre-requisites: You should have followed the "Installing" steps for all three applications first.

1) Step into the main folder and run a command console, and run migrations with the following command:

```
rails db:migrate RAILS_ENV=test
```

2) Enter the command below to run all tests:

```
$ rails t
```

This will run ALL application tests. You want to test controllers, or models alone, use:

```
$ rails test:controllers
```

```
$ rails test:models
```

After executing the chosen command, the test results will be displayed in the command console.

## Deployment

A live version of these app has already been deployed at [acid-challenge-jisanchez.herokuapp.com/](acid-challenge-jisanchez.herokuapp.com/)

If you want to deploy in your own account, follow this steps:

1) Install [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) in your local machine (if you don't have it already installed)

2) In the application root folder, open a command console and type the next commands to login on Heroku and add your SSH key

```
$ heroku login
$ heroku keys:add
```

3) Create the Heroku app:

```
$ heroku create
```

3.1) Optional step, rename your Heroku App with the following command (replace **best-name-ever** with the desired name:

```
$ heroku rename best-name-ever
```

After this, update you smtp_domain key in **config/application.yml** points to the heroku deployed [acid-challenge-app-two](https://github.com/jisanchezp/acid-challenge-app-two)

```
production:
  smtp_domain: '<your-app-two-heroku-domain>' # e.g. 'https//server-app-herokuapp.com'
```

4) Push the repository master branch to Heroku repository master branch:

```
$ git push heroku master
```

5) Install and configure SendGrid for your Heroku app:

```
$ heroku addons:create sendgrid:starter
-----> Adding sendgrid:starter to sharp-mountain-4005... done, v18 (free)
```

(If you get an error while executing the above command, you should verify your heroku account, if after that you are still blocked, submitt a ticket to Heroku Support, they should help you)

Once SendGrid has been added a **SENDGRID_USERNAME**, **SENDGRID_PASSWORD**:

```
$ heroku config:get SENDGRID_USERNAME
XXXXXXXXXXX@heroku.com

$ heroku config:get SENDGRID_PASSWORD
password
```

Follow the steps listed in the [Heroku Dev Center - Sendgrid Devcenter](https://devcenter.heroku.com/articles/sendgrid) page, to obtain a SendGrid API key, and add it to you Heroku app.

Once that is setup properly, update **config/application.yml**.

```
SENDGRID_USERNAME: '<you-sendgrid-username>'
SENDGRID_PASSWORD: '<you-sendgrid-username>'
```

And then execute the following to set all the environment variables to Heroku at once:

```
$ figaro heroku:set -e production
```

4) Finally, execute the next command to open your heroku application on the browser:

```
$ heroku open
```

## User management

First you should enter to your localhost, or production deployed site for **Acid Challenge App Two** (There's already a live application available at Heroku for manual testing purposes [acid-challenge-jisanchez.herokuapp.com/](acid-challenge-jisanchez.herokuapp.com/))

The created users list is shown, after that, user management is straightforward.

## Authors

* **Juan Ignacio Sánchez** - *Initial work* - [jisanchezp](https://github.com/jisanchezp)
