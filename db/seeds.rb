# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  [
    {
      email: 'test1@test',
      password: 'test1@test',
      name: '田中康二',
      nickname: 'Koooji',
      account_name: 'kojikoji',
      introduction: 'Snowpeakマニアの日常です！',
      profile_image: File.open('./app/assets/images/icon1.jpg')
    },
    {
      email: 'test2@test',
      password: 'test2@test',
      name: '田中優',
      nickname: 'ゆぅ',
      account_name: 'yuuuuu08',
      introduction: '週末はいつもソロキャンで癒されてます。。。',
      profile_image: File.open('./app/assets/images/icon2.jpg')
    },
    {
      email: 'test3@test',
      password: 'test3@test',
      name: '田中相馬',
      nickname: 'SOMA',
      account_name: 'SoMa777',
      introduction: 'ギアにこだわってます！',
      profile_image: File.open('./app/assets/images/icon3.jpg')
    }
  ]
)

Tag.create!(
  [
    {tag_name: "カップル", id: 1},
    {tag_name: "海キャン", id: 2},
    {tag_name: "焚き火", id: 3},
    {tag_name: "ソロキャン", id: 4},
    {tag_name: "newcup", id: 5},
    {tag_name: "ナイフ", id: 6},
    {tag_name: "new", id: 7},
    {tag_name: "breakfast", id: 8},
    {tag_name: "ランタン", id: 9},
    {tag_name: "レトロ", id: 10},
    {tag_name: "キャンプ飯", id: 11},
    {tag_name: "簡単料理", id: 12},
    {tag_name: "テントコーデ", id: 13},
    {tag_name: "レイアウト", id: 14},
    {tag_name: "テント", id: 15}
  ]
)


Post.create!(
  [
    {
      user_id: '1',
      body: '晴天！新しいチェアの座り心地が最高、、、',
      image: File.open('./app/assets/images/beach.jpg')
    },
    {
      user_id: '2',
      body: '週末は1人で。',
      image: File.open('./app/assets/images/campfire.jpg')
    },
    {
      user_id: '3',
      body: '新しいカップ可愛い♡',
      image: File.open('./app/assets/images/cup.jpg')
    },
    {
      user_id: '1',
      body: '新しいナイフの切り心地が最高です。',
      image: File.open('./app/assets/images/explosive.jpg')
    },
    {
      user_id: '2',
      body: 'ファミキャン',
      image: File.open('./app/assets/images/food.jpg')
    },
    {
      user_id: '3',
      body: 'お下がりのランタン',
      image: File.open('./app/assets/images/lantern.jpg')
    },
    {
      user_id: '1',
      body: 'トマト×ジャガイモのスープ',
      image: File.open('./app/assets/images/stew.jpg')
    },
    {
      user_id: '2',
      body: '新しい雑貨を使ってコーディネート！',
      image: File.open('./app/assets/images/tent1.jpg')
    },
    {
      user_id: '3',
      body: '今日のコーディネート',
      image: File.open('./app/assets/images/tent2.jpg')
    }
  ]
)

PostTag.create!(
  [
    {tag_id: '1', post_id: '1', id: 1},
    {tag_id: '2', post_id: '1', id: 2},
    {tag_id: '3', post_id: '2', id: 3},
    {tag_id: '4', post_id: '2', id: 4},
    {tag_id: '5', post_id: '3', id: 5},
    {tag_id: '6', post_id: '4', id: 6},
    {tag_id: '7', post_id: '4', id: 7},
    {tag_id: '8', post_id: '5', id: 8},
    {tag_id: '9', post_id: '6', id: 9},
    {tag_id: '10', post_id: '6', id: 10},
    {tag_id: '11', post_id: '7', id: 11},
    {tag_id: '12', post_id: '7', id: 12},
    {tag_id: '13', post_id: '8', id: 13},
    {tag_id: '14', post_id: '8', id: 14},
    {tag_id: '14', post_id: '9', id: 15},
    {tag_id: '15', post_id: '9', id: 16},
    {tag_id: '7', post_id: '1', id: 17},
    {tag_id: '15', post_id: '2', id: 18},
    {tag_id: '7', post_id: '3', id: 19},
    {tag_id: '10', post_id: '4', id: 20},
    {tag_id: '3', post_id: '5', id: 21},
    {tag_id: '7', post_id: '6', id: 22},
    {tag_id: '8', post_id: '7', id: 23},
    {tag_id: '7', post_id: '8', id: 24},
    {tag_id: '2', post_id: '9', id: 25}
  ]
)
