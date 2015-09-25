module.exports = (robot) ->
  robot.respond /roll (.*)/i, (res) ->
    res.reply "Rolling some dice"