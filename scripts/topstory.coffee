# Description:
#   <description of the scripts functionality>
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   ALCHEMY_API_KEY
#
# Commands:
#   hubot <trigger> - <what the respond trigger does>
#   <trigger> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   nyxsys

module.exports = (robot) ->
  robot.respond /story(.*)/i, (res) ->
    res.send "test"
    getStory res res.match[1] (StoryText) ->
      res.send "#{StoryText}"
  
getStory = (res, arg, cb) ->
    if true
      url= "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"
      res.http(url)
        .get() (err, res, body) ->
          result = JSON.parse(body)

          if result.error
            cb "#{result.error}"
            return
          else 
              response = "\n Your random headline:\n"
              response += "#{result.docs[0].source.enriched.url.title}\n"
              response += "#{result.docs[0].source.enriched.url.url}\n"
              cb response