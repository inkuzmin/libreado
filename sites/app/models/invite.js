// Generated by CoffeeScript 1.7.1
(function() {
  module.exports = function(config, mongoose, nodemailer, UserModel) {
    var InviteModel, InviteSchema, checkInvites, createInvite, crypto, handleEmail, sendInvite, sendInvites, _;
    crypto = require("crypto");
    _ = require("underscore");
    InviteSchema = new mongoose.Schema({
      email: {
        type: String,
        unique: true
      },
      sent: {
        type: Boolean,
        "default": false
      },
      used: {
        type: Boolean,
        "default": false
      },
      created: {
        type: Date,
        "default": Date.now
      }
    }, {
      strict: false
    });
    InviteModel = mongoose.model("invites", InviteSchema);
    createInvite = function(email) {
      var invite;
      invite = new InviteModel({
        email: email
      });
      return invite.save();
    };
    handleEmail = function(email) {
      createInvite(email);
      return checkInvites(sendInvites);
    };
    checkInvites = function(sendInvites) {
      return UserModel.count({}, function(err, total) {
        var freeInvites;
        freeInvites = config.maxUsers - total;
        if (freeInvites > 0) {
          return InviteModel.find({
            sent: false
          }).sort({
            created: -1
          }).limit(freeInvites).exec(function(err, invites) {
            return sendInvites(invites);
          });
        }
      });
    };
    sendInvites = function(invites) {
      return _.each(invites, function(invite) {
        return sendInvite(invite);
      });
    };
    sendInvite = function(invite) {
      var smtpTransport;
      smtpTransport = nodemailer.createTransport("SMTP", config.mail);
      return smtpTransport.sendMail({
        from: "invite@libreado.com",
        to: invite.email,
        subject: 'Invite to Libreado.com',
        text: 'Click here to reset your password: ' + invite._id
      }, function(err) {
        if (err) {
          return false;
        } else {
          return true;
        }
      });
    };
    return {
      handleEmail: handleEmail,
      createInvite: createInvite,
      InviteModel: InviteModel
    };
  };

}).call(this);

//# sourceMappingURL=invite.map