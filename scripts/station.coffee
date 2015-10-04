# Description:
#   <description of the scripts functionality>
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot <trigger> - <what the respond trigger does>
#   <trigger> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   <github username of the original script author>

module.exports = (robot) ->
  robot.respond /music/i, (msg) ->
    url = "https://piratrad.io/random"
    msg.http(url)
      .get() (err, res, body) ->
        body.replace /Moved Temporarily\. Redirecting to /, "" 
        msg.send "station link incoming: https://piratrad.io/#{body}"