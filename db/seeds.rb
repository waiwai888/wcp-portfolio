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
    },
    {
      email: 'guest@example.com',
      password: SecureRandom.urlsafe_base64,
      name: 'ゲスト1',
      nickname: 'ゲスト',
      account_name: 'guest1',
      introduction: 'ゲストユーザーでログイン中',
      profile_image: File.open('./app/assets/images/guest1.png')
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

hokkaido, tohoku, kanto, chubu, kinki, chugoku, shikoku, kyushu  = Region.create(
  [
    { name: '北海道地方' },
    { name: '東北地方' },
    { name: '関東地方' },
    { name: '中部地方' },
    { name: '近畿地方' },
    { name: '中国地方' },
    { name: '四国地方' },
    { name: '九州地方' }
  ]
)

['北海道'].each do |name|
  hokkaido.children.create(name: name)
end

['青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県'].each do |name|
  tohoku.children.create(name: name)
end

['東京都', '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '神奈川県'].each do |name|
  kanto.children.create(name: name)
end

['新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県'].each do |name|
  chubu.children.create(name: name)
end

['京都府', '大阪府', '三重県', '滋賀県', '兵庫県', '奈良県', '和歌山県'].each do |name|
  kinki.children.create(name: name)
end

['鳥取県', '島根県', '岡山県', '広島県', '山口県'].each do |name|
  chugoku.children.create(name: name)
end

['徳島県', '香川県', '愛媛県', '高知県'].each do |name|
  shikoku.children.create(name: name)
end

['福岡県', '佐賀県', '長崎県', '大分県', '熊本県', '宮崎県', '鹿児島県', '沖縄県'].each do |name|
  kyushu.children.create(name: name)
end

CampSite.create!(
    [
      {site_name: "ほったらかしキャンプ場", region_id: 10, id: 1},
      {site_name: "ふもとっぱらキャンプ場", region_id: 20, id: 2},
      {site_name: "朝霧高原キャンプ場", region_id: 30, id: 3},
      {site_name: "長瀞オートキャンプ場", region_id: 40, id: 4},
      {site_name: "一番星ヴィレッジ", region_id: 48, id: 5},
      {site_name: "イレブンオートキャンプパーク", region_id: 55, id: 6}
      ]
    )

Post.create!(
  [
    {
      user_id: '1',
      body: '晴天！新しいチェアの座り心地が最高、、、',
      image: File.open('./app/assets/images/beach.jpg'),
      camp_site_id: 1
    },
    {
      user_id: '2',
      body: '週末は1人で。',
      image: File.open('./app/assets/images/campfire.jpg'),
      camp_site_id: 2
    },
    {
      user_id: '3',
      body: '新しいカップ可愛い♡',
      image: File.open('./app/assets/images/cup.jpg'),
      camp_site_id: 3
    },
    {
      user_id: '1',
      body: '新しいナイフの切り心地が最高です。',
      image: File.open('./app/assets/images/explosive.jpg'),
      camp_site_id: 4
    },
    {
      user_id: '2',
      body: 'ファミキャン',
      image: File.open('./app/assets/images/food.jpg'),
      camp_site_id: 5
    },
    {
      user_id: '3',
      body: 'お下がりのランタン',
      image: File.open('./app/assets/images/lantern.jpg'),
      camp_site_id: 6
    },
    {
      user_id: '1',
      body: 'トマト×ジャガイモのスープ',
      image: File.open('./app/assets/images/stew.jpg'),
      camp_site_id: 1
    },
    {
      user_id: '2',
      body: '新しい雑貨を使ってコーディネート！',
      image: File.open('./app/assets/images/tent1.jpg'),
      camp_site_id: 2
    },
    {
      user_id: '3',
      body: '今日のコーディネート',
      image: File.open('./app/assets/images/tent2.jpg'),
      camp_site_id: 3
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
Relationship.create!(
  [
    {follower_id: '1', followed_id: '2', id: 1},
    {follower_id: '1', followed_id: '4', id: 2},
    {follower_id: '2', followed_id: '1', id: 3},
    {follower_id: '2', followed_id: '3', id: 4},
    {follower_id: '2', followed_id: '4', id: 5},
    {follower_id: '3', followed_id: '2', id: 6},
    {follower_id: '3', followed_id: '4', id: 7},
    {follower_id: '4', followed_id: '1', id: 8},
    {follower_id: '4', followed_id: '2', id: 9},
    {follower_id: '4', followed_id: '3', id: 10}
    ]
  )