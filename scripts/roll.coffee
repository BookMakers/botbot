module.exports = (robot) ->
  robot.respond /roll (.*)d(.*)(+|-)(.*)/i (res) ->
    res.reply "Rolling some dice"