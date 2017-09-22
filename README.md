# Twitter Clone

Basic Twitter clone using Ruby on Rails, just for funsies.

To view the application in production, visit https://frozen-sea-37864.herokuapp.com/

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
Then, visit localhost:3000 in your web browser

## Bugs and Issues

Because free deployment on Heroku is so slow, i have disabled email validation for account activation.  In order to activate the feature, uncomment code in the user 'create' method in users_controller.rb.  Next, uncomment the integration test in users_signup_test.rb.

Picture uploading for microposts:  feature currently disabled.  For the purposes of this application, I used an Amazon S3 bucket to store and upload pictures.  Users need to be authorized to use the S3 bucket, so I've disabled it for display purposes.  To activate it, simply uncomment the code in _micropost_form.html.erb
