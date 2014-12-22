# Description:
#   The Coding Love
#
# Dependencies:
#   jsdom
#
# Configuration:
#   None
#
# Commands:
#   hubot thecodinglove
#
# Author:
#

jsdom = require('jsdom').jsdom
jquery = 'http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
url = 'http://thecodinglove.com/random'

module.exports = (robot) ->
  robot.hear /thecodinglove/i, (msg) ->
    msg.http(url).get() (err, res, body) ->
      location = res.headers.location
      jsdom.env location, [jquery], (errors, window) ->
        (($) ->
          title = $('.post_title').text()
          image = $('.item img').attr('src')

          if title and image
            msg.send "#{title}"
            msg.send "#{image}"
        )(window.jQuery)
