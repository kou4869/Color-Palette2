# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if (Admin.where(email: 'color@admin').count == 0)
  Admin.create!(
    email: 'color@admin',
    password: 'coloradmin'
  )
end


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
    { name: 'うめ',
      email: 'ume@cat',
      password: 'umecat',
      introduction: '白に合う色を色々見てる'
    },
    { name: 'ウインディ',
      email: 'wind@cat',
      password: 'windcat',
      introduction: '見る専門です'
    },
    { name: 'リン',
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
    { tag_name: '暖色系' },   #1
    { tag_name: '寒色系' },   #2
    { tag_name: 'パステル' }, #3
    { tag_name: '彩' },       #4
    { tag_name: 'ダーク系' }, #5
    { tag_name: 'ライト系' }, #6
    { tag_name: 'きばつ' },   #7
    { tag_name: 'モノトーン'},#8
    { tag_name: '赤系'},      #9
    { tag_name: '青系' },     #10
    { tag_name: '黄系' },     #11
    { tag_name: '緑系'},      #12
    { tag_name: '白系'},      #13
    { tag_name: '黒系'}       #14
  ]
)

Post.create!(
  [
    { user_id: User.find_by(name: 'Marron').id,
      color1: '#ff7f50',
      color2: '#fafad2',
      color3: '#ff6347',
      color4: '#ffe4b5',
      post_introduction: '赤系の色とクリーム色の組み合わせたオリジナルです'
    },
    { user_id: User.find_by(name: 'オレオ').id,
      color1: '#000000',
      color2: '#ffffff',
      color3: '#000000',
      color4: '#ffffff',
      post_introduction: 'オレオと言ったらコレ'
    },
    { user_id: User.find_by(name: 'nya-').id,
      color1: '#cab8d9',
      color2: '#ffc0cb',
      color3: '#7fffd4',
      color4: '#fff8dc',
      post_introduction: '淡い系統の色でまとめました'
    },
    { user_id: User.find_by(name: '小鉄').id,
      color1: '#00bfff',
      color2: '#0000cd',
      color3: '#1e90ff',
      color4: '#4169e1',
      post_introduction: '全部あお！'
    },
    { user_id: User.find_by(name: 'teatea').id,
      color1: '#ffa500',
      color2: '#ffe4b5',
      color3: '#ffd700',
      color4: '#ffa07a',
      post_introduction: 'あたたかい雰囲気をイメージしました！'
    },
    { user_id: User.find_by(name: 'Marron').id,
      color1: '#7cfc00',
      color2: '#32cd32',
      color3: '#8b4513',
      color4: '#adff2f',
      post_introduction: '木の雰囲気'
    },
    { user_id: User.find_by(name: 'nya-').id,
      color1: '#ffe4c4',
      color2: '#cab8d9',
      color3: '#fff8dc',
      color4: '#7fffd4',
      post_introduction: 'パステル系の色の組み合わせ'
    },
    { user_id: User.find_by(name: 'リン').id,
      color1: '#ffff00',
      color2: '#ffe4b5',
      color3: '#fffacd',
      color4: '#f0e68c',
      post_introduction: '黄色系統でまとめました'
    },
    { user_id: User.find_by(name: 'リン').id,
      color1: '#f8f8ff',
      color2: '#fffaf0',
      color3: '#e6e6fa',
      color4: '#ffffff',
      post_introduction: '白系色',
    },
    { user_id: User.find_by(name: 'オレオ').id,
      color1: '#8b008b',
      color2: '#8a2be2',
      color3: '#e4007f',
      color4: '#800080',
      post_introduction: 'あやしい雰囲気の組み合わせ'
    },
    { user_id: User.find_by(name: 'teatea').id,
      color1: '#a52a2a',
      color2: '#32cd32',
      color3: '#cd5c5c',
      color4: '#98fb98',
      post_introduction: '若葉をイメージ'
    },
    { user_id: User.find_by(name: 'うめ').id,
      color1: '#ff4500',
      color2: '#ffd700',
      color3: '#2e8b57',
      color4: '#00bfff',
      post_introduction: '『Color Palette』のロゴの色！'
    },
  ]
)

#post_introduction tag_ids
introduction_tag_ids_hash = {
  '赤系の色とクリーム色の組み合わせたオリジナルです' => [ '暖色系', '赤系', '白系' ],
  'オレオと言ったらコレ' => [ 'モノトーン', '白系', '黒系' ],
  '淡い系統の色でまとめました' => [ 'パステル', '彩' ],
  '全部あお！' => [ '寒色系', '青系' ],
  'あたたかい雰囲気をイメージしました！' => [ '暖色系', '赤系', '黄系' ],
  '木の雰囲気' => [ '緑系' ],
  'パステル系の色の組み合わせ' => [ 'パステル', '彩', '緑系' ],
  '黄色系統でまとめました' => [ '暖色系', 'ライト系', '黄系' ],
  'あやしい雰囲気の組み合わせ' => [ 'ダーク系', 'きばつ' ],
  '若葉をイメージ' => [ '緑系' ],
  '『Color Palette』のロゴの色！' => [ '暖色系', '赤系', '緑系' ]
}


introduction_tag_ids_hash.each do |introduction, tag_names|
  post = Post.find_by(post_introduction: introduction)
  tag_names.each do |tag_name|
    post.post_tags.create(tag_id: Tag.find_by(tag_name: tag_name).id)
  end
end