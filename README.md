# Campist
![logo](https://user-images.githubusercontent.com/84080353/131309309-6e676456-a744-416c-8076-62f78274cf79.png)

## サイトテーマ
おすすめのキャンプコーディネート共有サイト
<img width="1792" alt="Campist-top" src="https://user-images.githubusercontent.com/84080353/131299832-35359fe1-a200-47c1-9e65-aad9e35b5609.png">

## サイト概要
キャンプでのあらゆる"コーディネート（テント、ファッション、料理等）"を楽しむSNSです。
ユーザー登録をすることで、多くの人のコーディネートを見ることができ、フォロー・いいね・コメントし合うことができます。
dmを使用し、コミュニケーションをとることができます。
投稿に紐付けたタグやカテゴリーで投稿を検索することができます

## サイトURL
http://52.198.169.110/

### テストアカウント
- email: test1@test
- password: test1@test

## 機能一覧
- ユーザー登録・ログイン機能(devise)
- 投稿機能
  - 画像投稿(refile)
  - タグ機能(ランキング機能）
- コメント機能(Ajax)
- いいね機能(Ajax)
- フォロー機能(Ajax)
- 画像スライダー(JQuery)
- 検索機能(同一検索窓/タグ・投稿本文)

### テスト
- Rspec（model/単体）

### レスポンシブ
- Sass
- Bootstrap

https://docs.google.com/spreadsheets/d/1Jq56_Ko5ymBgjyjmGk8KeJUPmFzBYqclVHiHuVsO22Y/edit?usp=sharing

## テーマを選んだ理由
キャンプが流行しており、キャンプの楽しみ方も多様化している中で、私自身テント内のレイアウトや服装を楽しむことが多く、
様々な人のコーディネートを参考にして楽しめるよう、共有する場があれば便利だと思ったため。
また、自分で今までのキャンプコーディネートを記録として残しておきたいため。

## ターゲットユーザ
1人〜家族のキャンプ好きな一般ユーザー

## 主な利用シーン
キャンプ場でのグッズの配置時やキャンプグッズを購入時にコーディネートを参考にレイアウトや服装、小物などを楽しめる

## 設計書
- フレームワーク：https://drive.google.com/file/d/1s3uLHHo8phah_HsUBP7ANJoqNmFi0AkH/view?usp=sharing
- ER図：https://drive.google.com/file/d/1RUkc-RbmabnTBp5EvdOj9KHCMm_VqYdu/view?usp=sharing
- テーブル定義書：https://docs.google.com/spreadsheets/d/1JUIzoOUOiG_pJQc4UNfTiXPTOwx1XDrcsCxIPj6JK70/edit?usp=sharing
- アプリケーション詳細設計書：https://docs.google.com/spreadsheets/d/1XYFIGh5ef1cC_JMlSYkiL2Evvxg5U4NEK2lC4NyYQKs/edit?usp=sharing

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 今後追加したい機能
- レビュー機能（キャンプ場、雑貨などのクチコミ投稿）
- 投稿画像拡張子統一(heicに対応)
- ユーザーの導線を考慮したページ遷移・レイアウト