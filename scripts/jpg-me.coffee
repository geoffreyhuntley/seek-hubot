# Description:
#   Shows images from jpg.to
#
# Configuration:
#   None
#
# Dependencies:
#
# Commands:
#   hubot jpg me <image name> - shows http://<image-name>.jpg.to
#
# Author:
#   grillp

module.exports = (robot) ->

  # Enable a looser regex if environment variable is set
  regex = /jpg me (.*)$/i

  robot.hear regex, (msg) ->
    what = msg.match[1].replace /\ /g, '-'
    msg.send "http://#{what}.jpg.to"
