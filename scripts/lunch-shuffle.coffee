# Description:
#   lunchをshuffleして、様々な人と一緒にlunchに行くためのものです
#
# Commands:
#   Hungry! - lunch-shuffleにエントリーする
#   hubot disp lunchers - lunch-shuffleにエントリーしている人を確認する。
#
cron = require('cron').CronJob
# lunch-shuffleの開始と初期化
module.exports = (robot) ->
  robot.enter ->
    new cron
      cronTime: "0 05 10 * * *"
      start: true
      timeZone: "Asia/Tokyo"
      onTick: ->
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "おはようございます！今からlunch-shuffleの受付を開始しますよ〜"
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "エントリーしたい方は、「hungry!」と叫んでくださいね〜！！"
        robot.brain.data.lunchers = []

  # 定期的なお知らせ11時,12時
  robot.enter ->
    new cron
      cronTime: "0 0 11, 12 * * *"
      start: true
      timeZone: "Asia/Tokyo"
      onTick: ->
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "【定期】lunch-shuffleに参加されたい方は「Hungry!」と叫んでください！！！"

  # 締め切り前をお知らせ12:30
  robot.enter ->
    new cron
      cronTime: "0 30 12 * * *"
      start: true
      timeZone: "Asia/Tokyo"
      onTick: ->
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "12:55に参加を締め切るのでエントリーはお早めに〜。「Hungry!」と叫んでくださいね〜"

  # エントリーの受付
  robot.hear /Hungry!/i, (msg) ->
    robot.brain.data.lunchers = [] unless robot.brain.data.lunchers
    robot.brain.data.lunchers.push(msg.message.user.name)
    msg.send "#{msg.message.user.name}: OK!"

  # 結果発表
  robot.enter ->
    new cron
      cronTime: "0 55 12 * * *"
      start: true
      timeZone: "Asia/Tokyo"
      onTick: ->
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "それではみなさまシャッフルの結果をお知らせします♪～(´ε｀ )"
        messages = []
        set = 0
        lunchers = robot.brain.data.lunchers

        for i in [(lunchers.length-1)..0] by -1
          p=(Math.random()*(i+1))|0
          [lunchers[p],lunchers[i]]=[lunchers[i],lunchers[p]]

        lunchers.forEach (luncher, i) ->
          if i % 4 == 0
            set++
            messages[set-1] = "#{set}組目: "
          messages[set-1] = messages[set-1] + luncher + 'さん '

        messages.forEach (message) ->
          robot.send {room:process.env.HUBOT_IRC_ROOMS}, message

        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "最後の人、２人以下になってしまった場合は、上の人と合流してください〜。"
        robot.send {room:process.env.HUBOT_IRC_ROOMS}, "何かバグがあったらすみません(ﾉ´∀｀*)"

  # lunchersの確認
  robot.respond /disp lunchers/i, (msg) ->
    message = ''
    robot.brain.data.lunchers.forEach (luncher) ->
      message = message + luncher + 'さん '

    if message == ''
      message = '誰もエントリーしてませんでした。。'

    msg.send message
