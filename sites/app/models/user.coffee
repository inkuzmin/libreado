module.exports = (config, mongoose) ->
  UserSchema = new mongoose.Schema
    email:
      type: String
      unique: true
    created:
      type: Date
      default: Date.now
  , strict: false


  UserModel = mongoose.model "users", UserSchema

  createUser = (email)->
    console.log 222
    user = new UserModel
    user.email = email
    user.save (err, doc)->
      console.log doc

  showUsers = ()->
    "pass"




  model: UserModel
  createUser: createUser