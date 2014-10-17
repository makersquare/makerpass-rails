# MakerPass-Rails

Quick way to get auth via makerpass on your rails app!

## Dependencies
  - [Rails](https://github.com/rails/rails)
  - [Figaro](https://github.com/laserlemon/figaro)
  - [Omniauth-Makersquare](https://github.com/makersquare/omniauth-makersquare)

## Quick setup

Register your app with Gilbert[at]makersquare.com. You will be given a key and secret.

run ```bundle exec figaro install```
this will create a file: config/application.yml
This is where you want to place your MKS key and secret:

```
MAKERSQUARE_KEY: SOME_SUPER_SECRET_KEY
MAKERSQUARE_SECRET: A_MORE_SECRET_SECRET_WHAAAT
```

Gemfile

```
gem "makerpass-rails", "~> 0.0.2"
```

run ```bundle install```

#### Route file  ```config/routes.rb```

```
mount MakerPass::Engine, at: "/"
```

#### Application Controller ```app/controllers/application_controllers.rb```

```
include MakerPass::Setup
make_auth User
```

### Requirements

- Your app must have a ```User``` model with columns ```name```, ```email```, ```avatar_url``` and ```uid```. All columns need to be type: ```string```. ```uid``` refers to the id MakerPass has assigned this user. Ideally you would want to have the ```uid``` indexed.


## Flow
*Login*:

Create a link to have a user login into makerpass: ```<%= link_to "Login", "/auth/makerpass" %>```

*Logout*:

Create a link to have a user logout: ```<%= link_to "Login", "/sessions", :method => :delete %>``

#### Method Helpers:
```current_user``` will return the user that is currently login in. If a user is not login, this method will return nil.

Use ```authenticate_user``` as a ```before_action``` option to protect certain controller actions from unauthorized users.

```
class PrivateController < ApplicationController
  before_action :authenticate_user

  def secret
      # will not run if visited by unauthorized user.
  end
end
```

## Configuration

Does your app not have a User model? Instead it has a Student model? Or perhaps a Animal model that you would like to authenticate? Awesome! Instead of passing ```User``` to ```make_authable``` method, pass in the model you would like to use!
I.e. if we had ```Student``` instead of ```User```:

**Application Controller** ```app/controllers/application_controllers.rb```

```
include MakerPass::Setup
make_auth Student
```

The Student table MUST have ```email```, ```name```, ```avatar_url```, and ```uid``` columns.

This will modify the helper methods. So instead of ```current_user``` you will receive ```current_student```. Instead of ```authenticate_user``` you will receive ```authenticate_student```.

#### Decide what to save

To override how a user is created when they login. Just overwrite ```#find_or_create_by_auth_hash``` on your authable model. i.e. in ```app/models/user.rb```


```
class User < ActiveRecord::Base
  def self.find_or_create_by_auth_hash(hash)
    User.find_or_create_by(uid: hash["uid"])
    # do new stuff
  end
end
```

The hash that is passed in looks like:
```
  {
    "ui" => "44",
    "info" => {
      "name" => "Bob Smith",
      "email" => "BobbyESmithy@gmail.com",
      "avatar_url" => "www.my_avatar_url.com"
    }
  }
```

*Notice:* string keys.

#### Redirect to different path after login / logout

You can override the path which the user gets redirected to in your ```app/controllers/application_controller.rb```.

```
  def after_sign_in_path
    "/explicit/after_sign_in_path"
  end

  def after_sign_out_path
    "/explicit/after_sign_out_path"
  end

```

** DO NOT USE PATH HELPERS HERE, i.e. ```users_path```, you MUST use a string. ** I'm unable to figure out a way to have path_helpers work in these methods without polluting Rails. PR anyone?

