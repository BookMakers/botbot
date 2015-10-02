# Description:
#   <description of the scripts functionality>
#
# Dependencies:
#   None right now
#
# Configuration:
#   ALCHEMY_API_KEY
#
# Commands:
#   hubot story <keyword> - returns a random story
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   nyxsys

module.exports = (robot) ->
  robot.respond /story ?(.*)?/i, (msg) ->
    buildUrl msg, (url) ->
      console.log url
      msg.http(url)
        .get() (err, res, body) ->
          doc = JSON.parse(body)
          if doc.error
            msg.send "#{doc.error}"
            return
          else 
              response = "\n Your random headline:\n"
              response += "#{doc.result.docs[0].source.enriched.url.title}\n"
              response += "#{doc.result.docs[0].source.enriched.url.url}\n"
              msg.send response
            
buildUrl = (msg, cb)->    
  if msg.match[1]
    keyword = msg.match[1]
    
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&maxResults=1&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=#{keyword}&return=enriched.url.url,enriched.url.title&apikey=#{process.env.ALCHEMY_API_KEY}"
  else
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"        
      
          
