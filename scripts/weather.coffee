# Description:
#   天気を調べる
#   This is a copy of https://github.com/masuilab/slack-hubot/blob/master/scripts/weather.coffee
#
# Commands:
#   hubot (天気|weather) 地名
#
# Author:
#   @shokai

{forecast} = require "weather-yahoo-jp"

module.exports = (robot) ->

  robot.respond /(天気|weather) (.+)/i, (msg) ->
    where = msg.match[2]
    forecast
      .get(where)
      .then (weather) ->
        res = []
        res.push "#{weather.where}"
        res.push "今日の天気は#{weather.today.text}、気温#{weather.today.temperature.low}〜#{weather.today.temperature.high}度"
        res.push "明日の天気は#{weather.tomorrow.text}、気温#{weather.tomorrow.temperature.low}〜#{weather.tomorrow.temperature.high}度"
        res.push weather.url
        msg.send res.join "\n"
