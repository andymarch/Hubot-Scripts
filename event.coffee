module.exports = (robot) ->

  event = 'eventname'
  msgWhen = new RegExp("(.*)when is "+event+"(.*)", 'i')
  msgHowLong = new RegExp(event+"|(.*)how long (until|till|to) "+event+"(.*)", 'i')
  eventDate = 'mm/dd/yyyy'
  preresponses = [
    """not long now"""",
    """keep waiting"""
  ]
  postresponses = [
    """you missed it""",
    """it has happened already"""
  ]

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
