# Description:
#   Script to count down to an event on a single given date.
#
# Dependencies:
#   none
#
# Configuration:
#   Set the event and eventDate in the script below, these determine the string to respond to and when the event will happen.
#   Configure the responses for before and after the event has occurred.
#
# Commands:
#   hubot when is <event> - Responds with the date of the event.
#   hubot how long until <event> - Provides the number of whole days until the event date plus a random preresponse, if the event is past a postresponse is given.
#
# Author:
#   Andy March <mail@andymarch.co.uk>

module.exports = (robot) ->

  #variables
  event = 'eventname'
  eventDate = 'mm/dd/yyyy'

  #customise the response strings
  #preresponses are appended to the number of days to go
  preresponses = [
    """not long now""",
    """keep waiting"""
  ]
  #postresponses are sent after the event has passed
  postresponses = [
    """you missed it""",
    """it has happened already"""
  ]

  #Parse the event name into regex strings to listen for
  msgWhen = new RegExp("(.*)when is "+event+"(.*)", 'i')
  msgHowLong = new RegExp(event+"|(.*)how long (until|till|to) "+event+"(.*)", 'i')

  robot.respond msgWhen, (res) ->
    res.send eventDate

  robot.respond msgHowLong, (res) ->
    now = new Date()
    eventTime = new Date(eventDate)
    if (now.getTime() > eventTime.getTime())
      res.send res.random postresponses
    else
      gap = eventTime.getTime() - now.getTime()
      gap =  Math.floor(gap / (1000 * 60 * 60 * 24))
      msg = res.random preresponses
      res.send  "#{gap} days #{msg}"
