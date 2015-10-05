# Description:
#   This script allows you to as hubot to get a story for you, he'll attempt to grab one from alchemy
#
# Dependencies:
#   None right now
#
# Configuration:
#   ALCHEMY_API_KEY
#
# Commands:
#   hubot story : returns a completely random story
#   hubot story <keyword>|<topic> -t : returns a story based on topic or keyword
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   nyxsys

module.exports = (robot) ->
  robot.respond /story ?([A-Za-z 0-9]*)? ?(-t)?/i, (msg) ->
    buildUrl msg, (url) ->
      #console.log url
      msg.http(url)
        .get() (err, res, body) ->
          doc = JSON.parse(body)
          if doc.status == "ERROR"
            msg.send "No more stories today"
            return
          else 
              try
                if  msg.match[1]
                  response = "\n A story about #{msg.match[1]}:\n"
                else
                  response = "\n Your random headline:\n"
                response += "#{doc.result.docs[0].source.enriched.url.title}\n"
                response += "#{doc.result.docs[0].source.enriched.url.url}\n"
                msg.send response
                return
              catch e
                if msg.match[2]
                  msg.send "#{msg.match[1]} doesn't seem to be a topic."
                  return
                else
                  msg.send "Don't have any stories about #{msg.match[1]}, sorry."
                  return
            
buildUrl = (msg, cb)-> 

  if msg.match[1]
    keyword = msg.match[1]
    keyword.replace /\ /g, "%20"
    if msg.match[2]
      cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&start=now-7d&end=now&maxResults=1&q.enriched.url.enrichedTitle.taxonomy.taxonomy_.label=#{keyword}&return=enriched,original"
      return 
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?outputMode=json&start=now-1d&end=now&maxResults=1&q.enriched.url.enrichedTitle.keywords.keyword.text=#{keyword}&return=enriched,original&apikey=#{process.env.ALCHEMY_API_KEY}"
  else
    cb "https://gateway-a.watsonplatform.net/calls/data/GetNews?apikey=#{process.env.ALCHEMY_API_KEY}&outputMode=json&outputMode=json&start=now-7d&end=now&maxResults=1&return=enriched,original"        
      
          
