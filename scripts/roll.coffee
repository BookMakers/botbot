module.exports = (robot) ->
  robot.respond /roll (.*)d(.*)/i, (res) ->
    dice = parseInt(res.match[2])
    amount = parseInt(res.match[1])
    if amount <= 15 && dice <=100
      total = 0
      i=1
      while i<=amount
        roll = Math.floor((Math.random() * dice)) + 1
        res.send "Roll #{i} was #{roll}"
        total = total + roll
        i++
        
      res.send "Rolling #{amount}d#{dice}, result is #{total}"
      
    else
      res.send "I can't count that high, sorry."
    
    