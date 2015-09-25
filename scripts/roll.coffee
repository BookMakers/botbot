module.exports = (robot) ->
  robot.respond /roll (.*)d(.*)(+|-)(.*)/i (res) ->
    dice = res.match[0]
    res.reply "Rolling some d#{dice}"