module.exports = (robot) ->
  robot.respond /roll (.*)d(.*)/i, (res) ->
    dice = parseInt(res.match[2])
    amount = parseInt(res.match[1])
    
    roll = (Math.random() * dice) + 1
    res.send "Rolling #{amount} d#{dice}, result is #{roll}"