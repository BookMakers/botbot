# Description:
#   A simple roller for hubot
#
#
#
# Commands:
#   hubot roll (diceamount)d(dicetype) +/- modifier - This rolls virtual dice, from 1d1 to 15d100, adding an 'e' to the end will print every roll
#
# Notes:
#   Rolls look like  hubot roll 1d20 for 
#   rolled 15
#   hubot roll 5d6e for 
#   dice 1 was 5
#   ...
#   dice 6 was 3
#   You rolled 18
#
# Author:
#   nyxys




module.exports = (robot) ->
  robot.respond /roll ([0-9]*)d([0-9]*)(\+|-)?([0-9]*)?(e)?/i, (res) ->
    mod = false
    show = false
    try
      
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
      res.send user, "Bad input"
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
      
      
    robot.respond /gmroll ([0-9]*)d([0-9]*)(\+|-)?([0-9]*)?(e)?/i, (res) ->
      mod = false
      show = false
      try
        
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
        res.send  user,, "Bad input"
        return
      
      if amount <= 15 && dice <=100
        total = 0
        i=1
        while i<=amount
          roll = Math.floor((Math.random() * dice)) + 1
          if show
            res.send user, "Roll #{i} was #{roll}"
          total = total + roll
          i++
        if mod
          if operator = '+'
            total = total + modifier
          else
            total = total - modifier
          
        res.send user, "Rolling #{amount}d#{dice}, result is #{total}"
        
      else
        res.senduser, "I can't count that high, sorry."
    
    