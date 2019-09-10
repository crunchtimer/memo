
# スタートプログラミングエキスパートコース課題③
## メモアプリ

このアプリはスタートプログラミングのエキスパートコースの課題③です。
メモアプリを作ります。

## ルール

以下に記述するアプリ要件（満たすべき動作）を守っていればどんな実装をしてもかまいません。  
また、自由に機能追加や改変をして、他の人とは違う、使いやすくて楽しいアプリを作ってください。  


## この課題で学ぶテーマ
- データの永続的保存方法を習得する
- テーブルによるリスト表示のおさらい
- 画面間のデータ受け渡しのおさらい

## この課題で新たに学習すること

まずはテキストには書いていない6つのことを学びます。  

- 配列の型
- UITableViewCellアクセサリー
- UINavigationBarへのBarButtonItem追加とアクションメソッド
- UIAlertController（ダイアログ）
- UserDefaults（データ保存）
- UITextView（テキスト入力）
- UITableViewの更新

## アプリ基本仕様

- アプリアイコンが設定されていること
- アプリ名が設定されていること
- どの端末でもレイアウトが崩れることなく表示されること
- アプリを終了しても保存したデータが保持されること

### 計算画面
#### 基本仕様

- 新規作成（＋）ボタンタップで新たなメモを作成することができる
- メモを保存するとリストに一覧をして表示される
- 保存したメモはアプリが終了しても消えず保持されること（ただしアプリ削除するとメモも消える）
- メモは削除することができ、削除するとリストからも消去されること

## ヒント

### UINavigationBarへのボタン追加

ナビゲーションバーへのボタンの配置はソースコードでも可能です。
UIBarButtonItemインスタンスを生成し、UINavigationItemに設置することで利用できます。

```
// 保存ボタンの設置
let barButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action:#selector(self.save))
self.navigationItem.rightBarButtonItem = barButton

// 保存ボタンタップ
@objc private func save(){}
````

上記ではボタンがタップされた場合のアクションメソッドとして「save( )」を定義しています。

### ダイアログ表示

削除してよいかの確認など、ユーザーに何かを確認させたい場合はダイアログを利用しましょう。
UIAlertControllerで簡単に表示することができます。

### データ保存

アプリを終了しても永続的にデータを保存したい場合は、UserDefaultsを利用します。

```
// 追加・更新
UserDefaults.standard.set({値}, forKey: {キー})

// 取得
UserDefaults.standard.string(forKey: {キー})
UserDefaults.standard.array(forKey: {キー})
UserDefaults.standard.dictionary(forKey: {キー})
UserDefaults.standard.data(forKey: {キー})
UserDefaults.standard.stringArray(forKey: {キー})
UserDefaults.standard.integer(forKey: {キー})
UserDefaults.standard.float(forKey: {キー})
UserDefaults.standard.double(forKey: {キー})
UserDefaults.standard.bool(forKey: {キー})
UserDefaults.standard.url(forKey: {キー})

// 削除
UserDefaults.standard.removeObject(forKey: {キー})
```

### テキスト入力

UITextViewを利用すると複数行のテキストを入力することができます。
1行の場合はUITextFieldを利用します。

