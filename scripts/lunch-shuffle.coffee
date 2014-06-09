# Description:
#   説明を書く
#
# Commands:
#   コマンドの説明を書く
#   hubot hello, I am <名前> - <名前> に挨拶をする
#
module.exports = (robot) ->
  robot.respond /post start/i, (msg) ->
    msg.send "おはようございます！今からlunch-shuffleの受付を開始しますよ〜"
    msg.send "エントリーしたい方は、「hungry!」と叫んでくださいね〜！！"
    robot.brain.data.lunchers = []

  robot.respond /post reminder/i, (msg) ->
    msg.send "【定期】lunch-shuffleに参加されたい方は「Hungry!」と叫んでください！！！"

  robot.respond /post dedline/i, (msg) ->
    msg.send "12:55に参加を締め切るのでエントリーはお早めに〜。「Hungry!」と叫んでくださいね〜"

  # エントリーの受付
  robot.hear /Hungry!/i, (msg) ->
    robot.brain.data.lunchers = [] unless robot.brain.data.lunchers
    robot.brain.data.lunchers.push(msg.message.user.name)
    msg.send "#{msg.message.user.name}: OK!"

  # 結果発表
  robot.respond /post result/i, (msg) ->
    msg.send "それではみなさまシャッフルの結果をお知らせします♪～(´ε｀ )"
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
      msg.send message

    msg.send '最後の人、２人以下になってしまった場合は、上の人と合流してください〜。'
    msg.send '何かバグがあったらすみません(ﾉ´∀｀*)'

  # lunchersの確認
  robot.respond /disp lunchers/i, (msg) ->
    message = ''
    robot.brain.data.lunchers.forEach (luncher) ->
      message = message + luncher + 'さん '

    if message == ''
      message = '誰もエントリーしてませんでした。。'

    msg.send message



