# Description:
#   Get information about a command from Bropages.org
#
# Configuration:
#   None
#
# Dependencies:
#
# Commands:
#   hubot rtfm|man|bropages <command> - Get information about a command from bropages.org
#
# Author:
#   Nevon
url = "http://bropages.org/"

sortBy = (key, a, b, r) ->
  r = if r then 1 else -1
  return -1*r if a[key] > b[key]
  return +1*r if a[key] < b[key]
  return 0

module.exports = (robot) ->
  robot.respond /(?:rtfm|man|bropages?) ([\w .\-]+)/i, (msg) ->
    command = msg.match[1].trim()
    response = ""
    robot.http("#{url}#{command}.json")
      .get() (err, res, body) ->
        if res.statusCode is 200
          examples = JSON.parse body
          examples = examples.sort (a,b) ->
            sortBy("up", a, b, true)
          
          if examples.length > 0
            response = "Examples for #{examples[0].cmd}:\n\n"
            response += "#{example.msg}\n\n" for example in examples
        else
          response = "Sorry, I couldn't find any information about #{command}"

        msg.reply response