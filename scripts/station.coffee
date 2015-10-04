# Description:
#   This script grabs a random station from piratrad.io and posts it
#
# Dependencies:
#   None!
#
# Configuration:
#   None!
#
# Commands:
#   hubot music - this will grab a random station from piratrad.io
#  
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   nyxsys

module.exports = (robot) ->
  robot.respond /music/i, (msg) ->
    url = "https://piratrad.io/random"
    msg.http(url)
      .get() (err, res, body) ->
        console.log body
        body.replace /to ?(.*)/, (match) -> 
          msg.send "station link incoming: https:/\/piratrad\.io/#{match[3..]}"