# lunch-shuffle-Hubot

ランチをいい感じにシャッフルしてくれます。

# 使い方

```
git clone git@github.com:mapyo/lunch-shuffle-hubot.git
cd lunch-master-hubot/bin
cp hubot-irc.default hubot-irc
vim hubot-irc
# 設定を変更してください
cd ..
./bin/hubot-irc
```

[Hubot + CoffeeScript ではじめるやわらかプログラミング入門](https://gist.github.com/udzura/0cb2447c305c51670414)をインスパイアして作られています。
`npm`等が入ってない場合は別途入れて下さい。
`redis`も入っているとよさそうです。

# 使用イメージ

`#lunch_shuffle`チャンネルにて。

```
# 10:05くらいに
lunch-master-hubot: おはようございます！今からlunch-shuffleの受付を開始しますよ〜
lunch-master-hubot: エントリーしたい方は、「hungry!」と叫んでくださいね〜！！

A : hungry!
lunch-master-hubot: A: OK!
B : hungry!
lunch-master-hubot: B: OK!
C : hungry!
lunch-master-hubot: C: OK!
D : hungry!
lunch-master-hubot: D: OK!
E : hungry!
lunch-master-hubot: E: OK!
F : hungry!
lunch-master-hubot: F: OK!
G : hungry!
lunch-master-hubot: G: OK!
H : hungry!
lunch-master-hubot: H: OK!

#12:55くらいに
lunch-master-hubot: それではみなさまシャッフルの結果をお知らせします♪～(´ε｀ )
lunch-master-hubot: 1組目 B, D, F, G
lunch-master-hubot: 2組目 A, C, E, H
lunch-master-hubot: 最後の人、２人以下になってしまった場合は、上の人と合流してください〜
lunch-master-hubot: 何かバグがあったらすみません(ﾉ´∀｀*)
```

