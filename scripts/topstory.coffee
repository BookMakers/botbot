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
#   hubot story <keyword> - returns a random story
#   <trigger> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   nyxsys

module.exports = (robot) ->
  robot.respond /story/i, (msg) ->
    url= "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"
    msg.http(url)
      .get() (err, res, body) ->
        doc = JSON.parse(body)
        if doc.error
          msg.send "#{doc.error}"
          return
        else 
            response = "\n Your random headline:\n"
            response += "#{doc.docs.source.enriched.url.title}\n"
            response += "#{doc.docs.source.enriched.url.url}\n"
            msg.send response
            
    
    """
    getStory res (StoryText) ->
      res.send "{StoryText}"
    """
"""
getStory = (res, cb) ->
    url= "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"
    res.http(url)
      .get() (err, res, body) ->
        result = JSON.parse(body)
        console.log "result"
        if result.error
          cb "{result.error}"
          return
        else 
            response = "\n Your random headline:\n"
            response += "{result.docs[0].source.enriched.url.title}\n"
            response += "{result.docs[0].source.enriched.url.url}\n"
            cb response
            
"""