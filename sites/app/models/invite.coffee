module.exports = (config, mongoose, nodemailer, UserModel) ->
  crypto = require "crypto"
  _ = require "underscore"

  InviteSchema = new mongoose.Schema
    email:
      type: String
      unique: true
    sent:
      type: Boolean
      default: false
    used:
      type: Boolean
      default: false
    created:
      type: Date
      default: Date.now
  , strict: false

  InviteModel = mongoose.model "invites", InviteSchema


  createInvite = (email) ->
    invite = new InviteModel email: email
    invite.save()

  handleEmail = (email) ->
    createInvite email
    checkInvites sendInvites

  checkInvites = (sendInvites)->
    UserModel.count {}, (err, total)->
      freeInvites = config.maxUsers - total
      if freeInvites > 0
        InviteModel
          .find sent: false
          .sort created: -1
          .limit freeInvites
          .exec (err, invites) ->
                  sendInvites invites

  sendInvites = (invites) ->
    _.each invites, (invite) ->
      sendInvite invite

  sendInvite = (invite) ->
    smtpTransport = nodemailer.createTransport "SMTP", config.mail
    smtpTransport.sendMail
      from: "invite@libreado.com"
      to: invite.email
      subject: 'Invite to Libreado.com'
      text: 'Click here to reset your password: ' + invite._id
    , (err) ->
      if (err)
#        callback false
          false
      else
#        callback true
          true

#    send via mailer


  handleEmail: handleEmail
  createInvite: createInvite
  InviteModel: InviteModel