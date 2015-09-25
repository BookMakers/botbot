module.exports = (robot) ->
  robot.respond /roll ([0-9]*)d([0-9]*)(\+|-)?([0-9]*)?(e)?/i, (res) ->
    mod = false
    show = false
    try
      #res.send "#{res.match[1]}"
      #res.send "#{res.match[2]}"
      #res.send "#{res.match[3]}"
      #res.send "#{res.match[4]}"
      
      dice = parseInt(res.match[2])
      amount = parseInt(res.match[1])
      if res.match[3] 
        operator = res.match[3]
        #res.send "#{operator}"
      if res.match[4]
        modifier = parseInt(res.match[4])
        #res.send "#{modifier}"
        mod = true
      if res.match[5]
        show = true
      
    catch error
      res.send "Bad input"
      return
    
    if amount <= 15 && dice <=100
      total = 0
      i=1
      while i<=amount
        roll = Math.floor((Math.random() * dice)) + 1
        if show
          res.send "Roll #{i} was #{roll}"
        total = total + roll
        i++
      if mod
        if operator = '+'
          total = total + modifier
        else
          total = total - modifier
        
      res.send "Rolling #{amount}d#{dice}, result is #{total}"
      
    else
      res.send "I can't count that high, sorry."
    
    