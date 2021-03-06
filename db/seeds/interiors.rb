# インテリア・住まい・小物の子カテゴリー配列
interior_child_array = 
    [
      'キッチン/食器',
      'ベッド/マットレス',
      'ソファ/ソファベッド',
      '椅子/チェア',
      '机/テーブル',
      '収納家具',
      'ラグ/カーペット/マット',
      'カーテン/ブラインド',
      'ライト/照明',
      '寝具',
      'インテリア小物',
      '季節/年中行事',
      'その他'
    ]

    interior_grandchild_array =
    [
      # 0:キッチン/食器
      [
        '食器',
        '調理器具',
        '収納/キッチン雑貨',
        '弁当用品',
        'カトラリー(スプーン等)',
        'テーブル用品',
        '容器',
        'エプロン',
        'アルコールグッズ',
        '浄水機',
        'その他'
      ],
      # 1:ベッド/マットレス
      [
        'セミシングルベッド',
        'シングルベッド',
        'セミダブルベッド',
        'ダブルベッド',
        'ワイドダブルベッド',
        'クイーンベッド',
        'キングベッド',
        '脚付きマットレスベッド',
        'マットレス',
        'すのこベッド',
        'ロフトベッド/システムベッド',
        '簡易ベッド/折りたたみベッド',
        '収納付き',
        'その他'
      ],
      # 2:ソファ/ソファベッド
      [
        'ソファセット',
        'シングルソファ',
        'ラブソファ',
        'トリプルソファ',
        'オットマン',
        'コーナーソファ',
        'ビーズソファ/クッションソファ',
        'ローソファ/フロアソファ',
        'ソファベッド',
        '応接セット',
        'ソファカバー',
        'リクライニングソファ',
        'その他'
      ],
      # 3:椅子/チェア
      [
        '一般',
        'スツール',
        'ダイニングチェア',
        'ハイバックチェア',
        'ロッキングチェア',
        '座椅子',
        '折り畳みイス',
        'デスクチェア',
        'その他'
      ],
      # 4:机/テーブル
      [
        'こたつ',
        'カウンターテーブル',
        'サイドテーブル',
        'センターテーブル',
        'ダイニングテーブル',
        '座卓/ちゃぶ台',
        'アウトドア用',
        'パソコン用',
        '事務机/学習机',
        'その他'
      ],
      # 5:収納家具
      [
        'リビング収納',
        'キッチン収納',
        '玄関/屋外収納',
        'バス/トイレ収納',
        '本収納',
        '本/CD/DVD収納',
        '洋服タンス/押入れ収納',
        '電話台/ファックス台',
        'ドレッサー/寝台',
        '棚/ラック',
        'ケース/ボックス',
        'その他'
      ],
      # 6:ラグ/カーペット/マット
      [
        'ラグ',
        'カーペット',
        'ホットカーペット',
        '玄関/キッチンマット',
        'トイレ/バスマット',
        'その他'
      ],
      # 7:カーテン/ブラインド
      [
        'カーテン',
        'ブラインド',
        'ロールスクリーン',
        'のれん',
        'その他'
      ],
      # 8:ライト/照明
      [
        '蛍光灯/電球',
        '天井照明',
        'フロアスタンド',
        'その他'
      ],
      # 9:寝具
      [
        '布団/毛布',
        '枕',
        'シーツ/カバー',
        'その他'
      ],
      # 10:インテリア小物
      [
        'ごみ箱',
        'ウェルカムボード',
        'オルゴール',
        'クッション',
        'クッションカバー',
        'スリッパラック',
        'ティッシュボックス',
        'バスケット/かご',
        'フォトフレーム',
        'マガジンラック',
        'モビール',
        '花瓶',
        '灰皿',
        '傘立て'
      ],
      # 11:季節/年中行事
      [
        '正月',
        '成人式',
        'バレンタインデー',
        'ひな祭り',
        '子どもの日',
        '母の日',
        '父の日',
        'サマーギフト/お中元',
        '夏/夏休み',
        'ハロウィン',
        '敬老の日',
        '七五三',
        'お歳暮',
        'クリスマス'
      ],
      # 12その他
      [
        'その他'
      ]
    ]

parent = Category.create(name: 'インテリア・住まい・小物')
interior_child_array.each_with_index do |child, i|
  child = parent.children.create(name: child)
  interior_grandchild_array[i].each do |grandchild|
    child.children.create(name: grandchild)
  end
end