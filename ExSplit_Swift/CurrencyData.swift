//
//  CurrencyData.swift
//  ExSplit_Swift
//
//  Created by 濱野遥斗 on 2024/08/04.
//

import Foundation

struct Currency: Codable, Hashable {
    let code: String
    let name: String
    let japaneseName: String
}

// ヨーロッパ
let europeanCurrencies: [Currency] = [
    Currency(code: "ALL", name: "Albanian Lek", japaneseName: "アルバニア・レク"),
    Currency(code: "AMD", name: "Armenian Dram", japaneseName: "アルメニア・ドラム"),
    Currency(code: "AZN", name: "Azerbaijani Manat", japaneseName: "アゼルバイジャン・マナト"),
    Currency(code: "BAM", name: "Bosnia and Herzegovina Mark", japaneseName: "ボスニア・ヘルツェゴビナ・マルク"),
    Currency(code: "BGN", name: "Bulgarian Lev", japaneseName: "ブルガリア・レフ"),
    Currency(code: "BYN", name: "Belarusian Ruble", japaneseName: "ベラルーシ・ルーブル"),
    Currency(code: "CHF", name: "Swiss Franc", japaneseName: "スイス・フラン"),
    Currency(code: "CZK", name: "Czech Koruna", japaneseName: "チェコ・コルナ"),
    Currency(code: "DKK", name: "Danish Krone", japaneseName: "デンマーク・クローネ"),
    Currency(code: "EUR", name: "Euro", japaneseName: "ユーロ"),
    Currency(code: "GBP", name: "Pound Sterling", japaneseName: "イギリス・ポンド"),
    Currency(code: "GEL", name: "Georgian Lari", japaneseName: "ジョージア・ラリ"),
    Currency(code: "HRK", name: "Croatian Kuna", japaneseName: "クロアチア・クーナ"),
    Currency(code: "HUF", name: "Hungarian Forint", japaneseName: "ハンガリー・フォリント"),
    Currency(code: "ISK", name: "Icelandic Króna", japaneseName: "アイスランド・クローナ"),
    Currency(code: "MDL", name: "Moldovan Leu", japaneseName: "モルドバ・レイ"),
    Currency(code: "MKD", name: "Macedonian Denar", japaneseName: "マケドニア・デナール"),
    Currency(code: "NOK", name: "Norwegian Krone", japaneseName: "ノルウェー・クローネ"),
    Currency(code: "PLN", name: "Polish Złoty", japaneseName: "ポーランド・ズウォティ"),
    Currency(code: "RON", name: "Romanian Leu", japaneseName: "ルーマニア・レイ"),
    Currency(code: "RSD", name: "Serbian Dinar", japaneseName: "セルビア・ディナール"),
    Currency(code: "RUB", name: "Russian Ruble", japaneseName: "ロシア・ルーブル"),
    Currency(code: "SEK", name: "Swedish Krona", japaneseName: "スウェーデン・クローナ"),
    Currency(code: "TRY", name: "Turkish Lira", japaneseName: "トルコ・リラ"),
    Currency(code: "UAH", name: "Ukrainian Hryvnia", japaneseName: "ウクライナ・フリブニャ")
]

// アジア
let asianCurrencies: [Currency] = [
    Currency(code: "AFN", name: "Afghan Afghani", japaneseName: "アフガニスタン・アフガニ"),
    Currency(code: "CNY", name: "Chinese Renminbi", japaneseName: "中国人民元"),
    Currency(code: "INR", name: "Indian Rupee", japaneseName: "インド・ルピー"),
    Currency(code: "IDR", name: "Indonesian Rupiah", japaneseName: "インドネシア・ルピア"),
    Currency(code: "IRR", name: "Iranian Rial", japaneseName: "イラン・リアル"),
    Currency(code: "IQD", name: "Iraqi Dinar", japaneseName: "イラク・ディナール"),
    Currency(code: "ILS", name: "Israeli New Shekel", japaneseName: "イスラエル・新シェケル"),
    Currency(code: "JPY", name: "Japanese Yen", japaneseName: "日本円"),
    Currency(code: "JOD", name: "Jordanian Dinar", japaneseName: "ヨルダン・ディナール"),
    Currency(code: "KZT", name: "Kazakhstani Tenge", japaneseName: "カザフスタン・テンゲ"),
    Currency(code: "KWD", name: "Kuwaiti Dinar", japaneseName: "クウェート・ディナール"),
    Currency(code: "KHR", name: "Cambodian Riel", japaneseName: "カンボジア・リエル"),
    Currency(code: "KRW", name: "South Korean Won", japaneseName: "韓国・ウォン"),
    Currency(code: "LAK", name: "Lao Kip", japaneseName: "ラオス・キープ"),
    Currency(code: "LBP", name: "Lebanese Pound", japaneseName: "レバノン・ポンド"),
    Currency(code: "MYR", name: "Malaysian Ringgit", japaneseName: "マレーシア・リンギット"),
    Currency(code: "MNT", name: "Mongolian Tögrög", japaneseName: "モンゴル・トゥグリグ"),
    Currency(code: "MMK", name: "Burmese Kyat", japaneseName: "ミャンマー・チャット"),
    Currency(code: "NPR", name: "Nepalese Rupee", japaneseName: "ネパール・ルピー"),
    Currency(code: "OMR", name: "Omani Rial", japaneseName: "オマーン・リアル"),
    Currency(code: "PKR", name: "Pakistani Rupee", japaneseName: "パキスタン・ルピー"),
    Currency(code: "PHP", name: "Philippine Peso", japaneseName: "フィリピン・ペソ"),
    Currency(code: "QAR", name: "Qatari Riyal", japaneseName: "カタール・リヤル"),
    Currency(code: "SAR", name: "Saudi Riyal", japaneseName: "サウジアラビア・リヤル"),
    Currency(code: "SGD", name: "Singapore Dollar", japaneseName: "シンガポール・ドル"),
    Currency(code: "SYP", name: "Syrian Pound", japaneseName: "シリア・ポンド"),
    Currency(code: "TJS", name: "Tajikistani Somoni", japaneseName: "タジキスタン・ソモニ"),
    Currency(code: "THB", name: "Thai Baht", japaneseName: "タイ・バーツ"),
    Currency(code: "TMT", name: "Turkmenistan Manat", japaneseName: "トルクメニスタン・マナト"),
    Currency(code: "UZS", name: "Uzbekistani So'm", japaneseName: "ウズベキスタン・スム"),
    Currency(code: "VND", name: "Vietnamese Đồng", japaneseName: "ベトナム・ドン"),
    Currency(code: "YER", name: "Yemeni Rial", japaneseName: "イエメン・リアル")
]

// 南北アメリカ
let americanCurrencies: [Currency] = [
    Currency(code: "ARS", name: "Argentine Peso", japaneseName: "アルゼンチン・ペソ"),
    Currency(code: "BBD", name: "Barbados Dollar", japaneseName: "バルバドス・ドル"),
    Currency(code: "BMD", name: "Bermudian Dollar", japaneseName: "バミューダ・ドル"),
    Currency(code: "BOB", name: "Bolivian Boliviano", japaneseName: "ボリビア・ボリビアーノ"),
    Currency(code: "BRL", name: "Brazilian Real", japaneseName: "ブラジル・レアル"),
    Currency(code: "BSD", name: "Bahamian Dollar", japaneseName: "バハマ・ドル"),
    Currency(code: "CAD", name: "Canadian Dollar", japaneseName: "カナダ・ドル"),
    Currency(code: "CLP", name: "Chilean Peso", japaneseName: "チリ・ペソ"),
    Currency(code: "COP", name: "Colombian Peso", japaneseName: "コロンビア・ペソ"),
    Currency(code: "CRC", name: "Costa Rican Colon", japaneseName: "コスタリカ・コロン"),
    Currency(code: "CUP", name: "Cuban Peso", japaneseName: "キューバ・ペソ"),
    Currency(code: "DOP", name: "Dominican Peso", japaneseName: "ドミニカ・ペソ"),
    Currency(code: "GTQ", name: "Guatemalan Quetzal", japaneseName: "グアテマラ・ケツァル"),
    Currency(code: "GYD", name: "Guyanese Dollar", japaneseName: "ガイアナ・ドル"),
    Currency(code: "HNL", name: "Honduran Lempira", japaneseName: "ホンジュラス・レンピラ"),
    Currency(code: "HTG", name: "Haitian Gourde", japaneseName: "ハイチ・グールド"),
    Currency(code: "JMD", name: "Jamaican Dollar", japaneseName: "ジャマイカ・ドル"),
    Currency(code: "MXN", name: "Mexican Peso", japaneseName: "メキシコ・ペソ"),
    Currency(code: "NIO", name: "Nicaraguan Córdoba", japaneseName: "ニカラグア・コルドバ"),
    Currency(code: "PAB", name: "Panamanian Balboa", japaneseName: "パナマ・バルボア"),
    Currency(code: "PEN", name: "Peruvian Sol", japaneseName: "ペルー・ソル"),
    Currency(code: "PYG", name: "Paraguayan Guaraní", japaneseName: "パラグアイ・グアラニー"),
    Currency(code: "SRD", name: "Surinamese Dollar", japaneseName: "スリナム・ドル"),
    Currency(code: "TTD", name: "Trinidad and Tobago Dollar", japaneseName: "トリニダード・トバゴ・ドル"),
    Currency(code: "USD", name: "United States Dollar", japaneseName: "米ドル"),
    Currency(code: "UYU", name: "Uruguayan Peso", japaneseName: "ウルグアイ・ペソ"),
    Currency(code: "VES", name: "Venezuelan Bolívar Soberano", japaneseName: "ベネズエラ・ボリバル")
]

// アフリカ
let africanCurrencies: [Currency] = [
    Currency(code: "AOA", name: "Angolan Kwanza", japaneseName: "アンゴラ・クワンザ"),
    Currency(code: "BIF", name: "Burundian Franc", japaneseName: "ブルンジ・フラン"),
    Currency(code: "BWP", name: "Botswana Pula", japaneseName: "ボツワナ・プラ"),
    Currency(code: "CDF", name: "Congolese Franc", japaneseName: "コンゴ・フラン"),
    Currency(code: "DJF", name: "Djiboutian Franc", japaneseName: "ジブチ・フラン"),
    Currency(code: "DZD", name: "Algerian Dinar", japaneseName: "アルジェリア・ディナール"),
    Currency(code: "EGP", name: "Egyptian Pound", japaneseName: "エジプト・ポンド"),
    Currency(code: "ERN", name: "Eritrean Nakfa", japaneseName: "エリトリア・ナクファ"),
    Currency(code: "ETB", name: "Ethiopian Birr", japaneseName: "エチオピア・ブル"),
    Currency(code: "GHS", name: "Ghanaian Cedi", japaneseName: "ガーナ・セディ"),
    Currency(code: "GMD", name: "Gambian Dalasi", japaneseName: "ガンビア・ダラシ"),
    Currency(code: "GNF", name: "Guinean Franc", japaneseName: "ギニア・フラン"),
    Currency(code: "KES", name: "Kenyan Shilling", japaneseName: "ケニア・シリング"),
    Currency(code: "KMF", name: "Comorian Franc", japaneseName: "コモロ・フラン"),
    Currency(code: "LRD", name: "Liberian Dollar", japaneseName: "リベリア・ドル"),
    Currency(code: "LSL", name: "Lesotho Loti", japaneseName: "レソト・ロティ"),
    Currency(code: "LYD", name: "Libyan Dinar", japaneseName: "リビア・ディナール"),
    Currency(code: "MAD", name: "Moroccan Dirham", japaneseName: "モロッコ・ディルハム"),
    Currency(code: "MGA", name: "Malagasy Ariary", japaneseName: "マダガスカル・アリアリ"),
    Currency(code: "MWK", name: "Malawian Kwacha", japaneseName: "マラウイ・クワチャ"),
    Currency(code: "MZN", name: "Mozambican Metical", japaneseName: "モザンビーク・メティカル"),
    Currency(code: "NAD", name: "Namibian Dollar", japaneseName: "ナミビア・ドル"),
    Currency(code: "NGN", name: "Nigerian Naira", japaneseName: "ナイジェリア・ナイラ"),
    Currency(code: "RWF", name: "Rwandan Franc", japaneseName: "ルワンダ・フラン"),
    Currency(code: "SCR", name: "Seychellois Rupee", japaneseName: "セーシェル・ルピー"),
    Currency(code: "SDG", name: "Sudanese Pound", japaneseName: "スーダン・ポンド"),
    Currency(code: "SHP", name: "Saint Helena Pound", japaneseName: "セントヘレナ・ポンド"),
    Currency(code: "SLL", name: "Sierra Leonean Leone", japaneseName: "シエラレオネ・レオン"),
    Currency(code: "SOS", name: "Somali Shilling", japaneseName: "ソマリア・シリング"),
    Currency(code: "SSP", name: "South Sudanese Pound", japaneseName: "南スーダン・ポンド"),
    Currency(code: "SZL", name: "Eswatini Lilangeni", japaneseName: "エスワティニ・リランゲニ"),
    Currency(code: "TZS", name: "Tanzanian Shilling", japaneseName: "タンザニア・シリング"),
    Currency(code: "UGX", name: "Ugandan Shilling", japaneseName: "ウガンダ・シリング"),
    Currency(code: "XAF", name: "Central African CFA Franc", japaneseName: "中央アフリカCFAフラン"),
    Currency(code: "XOF", name: "West African CFA franc", japaneseName: "西アフリカCFAフラン"),
    Currency(code: "ZAR", name: "South African Rand", japaneseName: "南アフリカ・ランド"),
    Currency(code: "ZMW", name: "Zambian Kwacha", japaneseName: "ザンビア・クワチャ"),
    Currency(code: "ZWL", name: "Zimbabwean Dollar", japaneseName: "ジンバブエ・ドル")
]

// オセアニア
let oceanianCurrencies: [Currency] = [
    Currency(code: "AUD", name: "Australian Dollar", japaneseName: "オーストラリア・ドル"),
    Currency(code: "FJD", name: "Fiji Dollar", japaneseName: "フィジー・ドル"),
    Currency(code: "NZD", name: "New Zealand Dollar", japaneseName: "ニュージーランド・ドル"),
    Currency(code: "PGK", name: "Papua New Guinean Kina", japaneseName: "パプアニューギニア・キナ"),
    Currency(code: "SBD", name: "Solomon Islands Dollar", japaneseName: "ソロモン諸島・ドル"),
    Currency(code: "TVD", name: "Tuvaluan Dollar", japaneseName: "ツバル・ドル"),
    Currency(code: "VUV", name: "Vanuatu Vatu", japaneseName: "バヌアツ・バツ"),
    Currency(code: "WST", name: "Samoan Tālā", japaneseName: "サモア・タラ")
]
