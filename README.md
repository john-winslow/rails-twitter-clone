# Twitter Clone

Basic Twitter clone using Ruby on Rails, just for funsies.

Things to refresh/practice:

* Building a rails app from scratch (no scaffolding)

* Security (bcrypt for password hashing)

* Use JS to make single page, dynamc app


## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```