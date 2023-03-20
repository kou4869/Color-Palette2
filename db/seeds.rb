# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'color@admin',
  password: 'coloradmin'
)


User.create!(
  [
    { name: 'nya-',
      email: 'nya@cat',
      password: 'nyacat',
      introduction: '淡い色合いが好きです'
    },
    { name: 'オレオ',
      email: 'oreo@cat',
      password: 'oreocat',
      introduction: 'モノトーンカラーが好みです'
    },
    { name: 'Marron',
      email: 'marron@cat',
      password: 'marroncat',
      introduction: '暖色系の色合いが好みです'
    },
    { name: '小鉄',
      email: 'kotetu@cat',
      password: 'kotetucat',
      introduction: '青系統の配色が気になる'
    },
    { name: '梅',
      email: 'ume@cat',
      password: 'umecat',
      introduction: '白に合う色を色々見てる'
    },
    { name: 'ウインディ',
      email: 'wind@cat',
      password: 'windcat',
      introduction: '見る専門です'
    },
    { name: '鈴',
      email: 'rin@cat',
      password: 'rindcat',
      introduction: '投稿用アカウント'
    },
    { name: 'teatea',
      email: 'teatea@cat',
      password: 'teateadcat',
      introduction: '茶色系っていい色ですよね'
    },
  ]
)

Tag.create!(
  [
    { tag_name: '暖色系' }, 
    { tag_name: '寒色系' },
    { tag_name: 'パステル' },
    { tag_name: '彩' },
    { tag_name: 'ダーク系' },
    { tag_name: 'ライト系' },
    { tag_name: 'きばつ' },
    { tag_name: 'モノトーン'},
    { tag_name: '赤系'},
    { tag_name: '青系' },
    { tag_name: '黄系' },
    { tag_name: '緑系'},
    { tag_name: '白系'},
    { tag_name: '黒系'}
  ]
)

Post.create!(
  [
    { user_id: 7,
      color1: coral,
      color2: lightgoldenrodyellow,
      color3: tomato,
      color4: moccasin,
      post_introduction: '赤系の色とクリーム色の組み合わせたオリジナルです',
      tag_id: 1,
    },
    { user_id: 2,
      color1: black,
      color2: white,
      color3: black,
      color4: white,
      post_introduction: 'オレオと言ったらコレ',
      tag_id: 1,
    },
    { user_id: 1,
      color1: lavender,
      color2: pink,
      color3: aquamarine,
      color4: cornsilk,
      post_introduction: '淡い系統の色でまとめました',
      tag_id: 3,
    },
    { user_id: 4,
      color1: deepskyblue,
      color2: mediumblue,
      color3: dodgerblue,
      color4: royalblue,
      post_introduction: '全部あお！',
      tag_id: 10,
    },
    { user_id: 3,
      color1: orange,
      color2: moccasin,
      color3: gold,
      color4: lightsalmon,
      post_introduction: 'あたたかい雰囲気をイメージしました！',
      tag_id: 11,
    },
    { user_id: 8,
      color1: lawngreen,
      color2: limegreen,
      color3: saddlebrown,
      color4: greenyellow,
      post_introduction: '木の雰囲気',
      tag_id: 4,
    },
    { user_id: 1,
      color1: bisque,
      color2: lavender,
      color3: cornsilk,
      color4: aquamarine,
      post_introduction: '木の雰囲気',
      tag_id: 6,
    },
    { user_id: 7,
      color1: yellow,
      color2: moccasin,
      color3: lemonchiffon,
      color4: khaki,
      post_introduction: '木の雰囲気',
      tag_id: 11,
    },
    { user_id: 7,
      color1: ghostwhite,
      color2: lightyellow,
      color3: aliceblue,
      color4: cornsilk,
      post_introduction: '白系色',
      tag_id: 13,
    },
    { user_id: 2,
      color1: darkmagenta,
      color2: darkgray,
      color3: magenta,
      color4: lightslategray,
      post_introduction: 'あやしい雰囲気の組み合わせ',
      tag_id: 5,
    },
    { user_id: 8,
      color1: brown,
      color2: limegreen,
      color3: indianred,
      color4: palegreen,
      post_introduction: '若葉をイメージ',
      tag_id: 4,
    },
  ]
)



Post.all.each do |post|
  post.tags << Tag.find(rand(1..4))
end