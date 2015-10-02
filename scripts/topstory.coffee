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
          if doc.status == "ERROR"
            msg.send "No more stories today"
            return
          else 
              if  msg.match[1]
                response = "\n A story about #{msg.match[1]}:\n"
              else
                response = "\n Your random headline:\n"
              response += "#{doc.result.docs[0].source.enriched.url.title}\n"
              response += "#{doc.result.docs[0].source.enriched.url.url}\n"
              msg.send response
            
buildUrl = (msg, cb)->    
  if msg.match[1]
    keyword = msg.match[1]
    
    #cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&start=now-7d&end=now&maxResults=1&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=#{keyword}&return=enriched,original"
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&maxResults=1&q.enriched.url.enrichedTitle.keywords.keyword.text=#{keyword}&return=enriched,original&apikey=#{process.env.ALCHEMY_API_KEY}"
  
  else
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"        
      
          
