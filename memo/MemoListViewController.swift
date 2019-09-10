//
//  MemoListViewController.swift
//  メモリスト画面
//
//  Created by Kota Sasaki on 2019/09/09.
//  Copyright © 2019 Crunchtimer Inc. All rights reserved.
//

import UIKit

class MemoListViewController: UITableViewController {

    // メモ保存用UserDefaultsキー
    let KEY_MEMO_LIST = "key_memo_list"
    
    // メモリストデータ
    var list:[String] = []
    
    // メモリスト選択番号
    var selectIndex = -1
    
    // 画面表示時に一度だけ処理されるUIViewControllerのメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面タイトルの設定
        title = "メモ"
        
        // UserDefaultsにメモデータがあるかチェック
        // HACK: 下記のように書くことでnilチェックを同時にやっています
        if let data = UserDefaults.standard.array(forKey: KEY_MEMO_LIST) {
            // メモデータを読み込み
            self.list = data as! [String]
        }
    }

    // テーブルリストのセル件数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // リストの表示件数を返却
        return list.count
    }

    // テーブルセルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // セルのインスタンスを生成
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // セル（メモ）タイトルの設定
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
    
    // テーブルセルタップ
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // タップしたセルの番号を保存
        selectIndex = indexPath.row
        
        // 次の画面へ遷移
        self.toNextPage()
    }
    
    // 新規追加（＋ボタンタップ）
    @IBAction func newTap(_ sender: Any) {
        
        // 選択番号を新規追加に設定
        self.selectIndex = -1
        
        // 次の画面へ遷移
        self.toNextPage()
    }
    
    // 次画面遷移
    private func toNextPage() {
        
        // メモ詳細画面に遷移
        performSegue(withIdentifier: "toMemoDetailViewController", sender: nil)
    }
    
    // 画面遷移前処理
    // ※ 次画面に遷移する直前に呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // メモ詳細画面のインスタンス取得
        let vc = segue.destination as! MemoDetailViewController

        // 選択インデックスの保存
        vc.index = self.selectIndex

        // 新規作成ではない場合
        if self.selectIndex != -1 {
            vc.text = self.list[self.selectIndex]
        }
        
        // クロージャ（メモ画面で保存されたら処理が戻ってくる）
        vc.closureSave = { (text: String, index: Int) -> Void in

            // メモの新規追加
            if index == -1 {
                // 入力したメモリストに追加
                self.list.append(text)
            }
            // メモの更新
            else {
                // 入力したメモに置き換え
                self.list[index] = text
            }
            
            // UserDefaultsにメモのデータを保存
            self.memoUserDefaultsSave()

            // テーブル一覧の更新
            self.tableView.reloadData()
        }
        // クロージャ（メモ画面で削除されたら処理が戻ってくる）
        vc.closureDelete = { (index: Int) -> Void in
            
            // 配列から指定のメモを削除
            self.list.remove(at: self.selectIndex)
            
            // UserDefaultsにメモのデータを保存
            self.memoUserDefaultsSave()
            
            // テーブル一覧の更新
            self.tableView.reloadData()
        }
    }
    
    // UserDefaultsにメモのデータを保存
    private func memoUserDefaultsSave() {
        
        // メモを保存
        UserDefaults.standard.set(self.list, forKey: KEY_MEMO_LIST)
    }
}
