place_names= [
  "デットフレイ",
  "ヴィクトリアの滝",
  "ルクソール",
  "ラリベラ岩窟教会群",
  "アイトベンハドゥ", "サハラ砂漠",
  "セブンカラードアース",
  "ラック・ローズ",
  "チヴィタディバニョレージョ",
  "ドロミテ渓谷",
  "マテーラの洞窟住居",
  "グロッタ・アズッラ",
  "セリャラントスフォス",
  "ハットルグリムス教会",
  "バトナ氷河",
  "ゲイシール",
  "リーセフィヨルド",
  "トロルの舌",
  "モン・サン・ミシェル",
  "ストーンヘンジ",
  "セブンシスターズ",
  "バイカル湖",
  "スワローズネスト",
  "スタリモスト橋",
  "ナヴァイオビーチ",
  "メテオラ修道院",
  "ノイシュバンシュタイン城",
  "ブレッド湖",
  "マッターホルン",
  "プリトヴィッツェ湖群国立公園",
  "シェイクザビードグランドモスク",
  "バッカス寺院",
  "クアンシーの滝",
  "ペトラ遺跡",
  "ペトラトゥロミウ海岸",
  "ヒエラポリス-パムッカレ",
  "チョコレートヒルズ",
  "エルニド",
  "蘆笛岩",
  "万里の長城",
  "アンコールワット",
  "シュエサンドーパゴダ",
  "パンゴン湖",
  "シーギリヤ",
  "高美湿地",
  "イジェン火山",
  "ミルフォードサウンドフィヨルド",
  "テカポ湖",
  "ワイトモ洞窟",
  "ケーブルビーチ",
  "ブルーマウンテンズ",
  "エアーズロック",
  "ホワイトヘブンビーチ",
  "モニュメントバレー",
  "アンテロープキャニオン",
  "サルベーションマウンテン",
  "ザウェーブ",
  "カセドラルロック",
  "プライスキャニオン国立公園",
  "ホースシューベンド",
  "ホワイトサンズ国立公園",
  "グランドキャニオン国立公園",
  "バラデロ",
  "チェチェンイッツァ",
  "グランセノーテ",
  "アブラハム湖",
  "レイク・ルイーズ",
  "イグアスの滝",
  "ロス・グラシアレス国立公園",
  "グラシアル・ペリート・モレノ",
  "ウユニ塩湖",
  "ヴィニクンカ山",
  "マチュピチュ",
  "レンソイス国立公園",
  "フェルナンド・デ・ノローニャ",
  "エンジェルフォール",
  "ヘネラル・カレーラ湖",
]

place_names.each do |place_name|
  place = Place.new(name: place_name)
  place.portrait.attach(io: File.open("public/images/#{place_name}.avif"), filename: "#{place_name}.avif")
  place.save!
end

state_names = ["アフリカ", "ヨーロッパ", "中東", "アジア", "オセアニア", "北米", "南米"]
state_names.each do |name|
  State.create!(name: name)
end

state_country_names = {
  "アフリカ": ["ナミビア", "ザンビア", "エジプト", "エチオピア", "モロッコ", "モーリシャス", "セネガル", "ジンバブエ"],
  "ヨーロッパ": ["イタリア", "アイスランド", "ノルウェー", "フランス", "イギリス", "ロシア", "ウクライナ", "ボスニアヘルツェゴビナ",
                "ギリシャ", "ドイツ", "スロベニア", "スイス", "クロアチア"],
  "中東": ["アラブ首長国連邦", "レバノン", "ラオス", "ヨルダン", "キプロス", "トルコ"],
  "アジア": ["フィリピン", "中国", "カンボジア", "ミャンマー", "インド", "スリランカ", "台湾", "インドネシア"],
  "オセアニア": ["ニュージーランド", "オーストラリア"],
  "北米": ["アメリカ", "キューバ", "メキシコ", "カナダ"],
  "南米": ["アルゼンチン", "ボリビア", "ペルー", "ブラジル", "ベネズエラ", "チリ"]
}

state_country_names.each do |key, value|
  state = State.find_by(name: key)
  value.each do |country_name|
    Country.create!(name: country_name, state: state)
  end
end

country_place_names = {
  ナミビア: ["デットフレイ"],
  ザンビア: ["ヴィクトリアの滝"],
  エジプト: ["ルクソール"],
  エチオピア: ["ラリベラ岩窟教会群"],
  モロッコ: ["アイトベンハドゥ", "サハラ砂漠"],
  モーリシャス: ["セブンカラードアース"],
  セネガル: ["ラック・ローズ"],
  ジンバブエ: ["ヴィクトリアの滝"],
  イタリア: ["チヴィタディバニョレージョ", "ドロミテ渓谷", "マテーラの洞窟住居", "グロッタ・アズッラ", "マッターホルン"],
  アイスランド: ["セリャラントスフォス", "ハットルグリムス教会", "バトナ氷河", "ゲイシール"],
  ノルウェー: ["リーセフィヨルド", "トロルの舌"],
  フランス: ["モン・サン・ミシェル"],
  イギリス: ["ストーンヘンジ", "セブンシスターズ"],
  ロシア: ["バイカル湖"],
  ウクライナ: ["スワローズネスト"],
  ボスニアヘルツェゴビナ: ["スタリモスト橋"],
  ギリシャ: ["ナヴァイオビーチ", "メテオラ修道院"],
  ドイツ: ["ノイシュバンシュタイン城"],
  スロベニア: ["ブレッド湖"],
  スイス: ["マッターホルン"],
  クロアチア: ["プリトヴィッツェ湖群国立公園"],
  アラブ首長国連邦: ["シェイクザビードグランドモスク"],
  レバノン: ["バッカス寺院"],
  ラオス: ["クアンシーの滝"],
  ヨルダン: ["ペトラ遺跡"],
  キプロス: ["ペトラトゥロミウ海岸"],
  トルコ: ["ヒエラポリス-パムッカレ"],
  フィリピン: ["チョコレートヒルズ", "エルニド"],
  中国: ["蘆笛岩", "万里の長城"],
  カンボジア: ["アンコールワット"],
  ミャンマー: ["シュエサンドーパゴダ"],
  インド: ["パンゴン湖"],
  スリランカ: ["シーギリヤ"],
  台湾: ["高美湿地"],
  インドネシア: ["イジェン火山"],
  ニュージーランド: ["ミルフォードサウンドフィヨルド", "テカポ湖", "ワイトモ洞窟"],
  オーストラリア: ["ケーブルビーチ", "ブルーマウンテンズ", "エアーズロック", "ホワイトヘブンビーチ"],
  アメリカ: ["モニュメントバレー", "アンテロープキャニオン", "サルベーションマウンテン", "ザウェーブ",
            "カセドラルロック", "プライスキャニオン国立公園", "ホースシューベンド", "ホワイトサンズ国立公園",
            "グランドキャニオン国立公園" ],
  キューバ: ["バラデロ"],
  メキシコ: ["チェチェンイッツァ", "グランセノーテ"],
  カナダ: ["アブラハム湖", "レイク・ルイーズ"],
  アルゼンチン: ["イグアスの滝", "ロス・グラシアレス国立公園", "グラシアル・ペリート・モレノ"],
  ボリビア: ["ウユニ塩湖"],
  ペルー: ["ヴィニクンカ山", "マチュピチュ"],
  ブラジル: ["レンソイス国立公園", "フェルナンド・デ・ノローニャ", "イグアスの滝"],
  ベネズエラ: ["エンジェルフォール"],
  チリ: ["ヘネラル・カレーラ湖"],
}

country_place_names.each do |key, value|
  country = Country.find_by(name: key)
  value.each do |place_name|
    place = Place.find_by(name: place_name)
    place.countries << country
  end
end
