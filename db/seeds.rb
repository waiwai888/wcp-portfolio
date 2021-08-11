# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |n|
  User.create(
    email: "test#{n + 1}@test",
    password: "test#{n + 1}@test",
    name: "田中太郎#{n + 1}",
    account_name: "test#{n + 1}@test",
    nickname: "太郎#{n + 1}",
    introduction: "よろしくお願いします#{n + 1}",
    profile_image: File.open("./app/assets/images/icon#{n + 1}.jpg")
  )
end

Tag.create!(
  [
    {tag_name: "カップル"},
    {tag_name: "海キャン"},
    {tag_name: "焚き火"},
    {tag_name: "ソロキャン"},
    {tag_name: "newcup"},
    {tag_name: "ナイフ"},
    {tag_name: "new"},
    {tag_name: "breakfast"},
    {tag_name: "ランタン"},
    {tag_name: "レトロ"},
    {tag_name: "キャンプ飯"},
    {tag_name: "簡単料理"},
    {tag_name: "テントコーデ"},
    {tag_name: "レイアウト"},
    {tag_name: "テント"},
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
    {tag_id: '1,2', post_id: '1'},
    {tag_id: '3,4', post_id: '2'},
    {tag_id: '5', post_id: '3'},
    {tag_id: '6,7', post_id: '4'},
    {tag_id: '8', post_id: '5'},
    {tag_id: '9,10', post_id: '6'},
    {tag_id: '11,12', post_id: '7'},
    {tag_id: '13,14', post_id: '8'},
    {tag_id: '14,15', post_id: '9'}
  ]
)
