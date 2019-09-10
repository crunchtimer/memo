//
//  MemoDetailViewController.swift
//  メモ詳細画面
//
//  Created by Kota Sasaki on 2019/09/09.
//  Copyright © 2019 Crunchtimer Inc. All rights reserved.
//

import UIKit

class MemoDetailViewController: UIViewController {

    // テキスト入力フォーム
    @IBOutlet weak var textView: UITextView!
    
    // ゴミ箱ボタン
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    // 初期設定用文字列（リスト画面から設定）
    var text:String = ""
    
    // リストのインデックス（新規の場合は-1）
    var index: Int = -1
    
    /// 保存用クロージャー
    /// parameters
    ///     - String: 入力したメモテキスト
    ///     - Int: リストの番号
    /// return
    ///     - Void
    var closureSave: ((String, Int) -> Void)?

    /// 削除用クロージャー
    /// parameters
    ///     - Int: リストの番号
    /// return
    ///     - Void
    var closureDelete: ((Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // テキストビューを初期化
        textView.text = self.text
        
        // 保存ボタンの設置
        let barButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action:#selector(self.save))
        self.navigationItem.rightBarButtonItem = barButton
        
        // ゴミ箱ボタンの有効/無効設定（新規の場合は無効）
        self.trashButton.isEnabled = index == -1 ? false : true
    }
    
    // 保存ボタンタップ
    @objc private func save() {

        // メモを保存するためリスト画面に入力したテキストを送る
        self.closureSave!(self.textView.text!, self.index)
        
        // 前画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    /// ゴミ箱ボタンタップ
    @IBAction func trashTap(_ sender: Any) {
        
        /// ① UIAlertControllerインスタンス生成
        /// タイトル, メッセージ, アラートダイアログのスタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "確認", message: "削除しますか？", preferredStyle: .alert)
        
        // ② アクションの設定
        // アクション初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // OKボタンの生成
        let okButton: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            
                // メモを削除
                self.closureDelete?(self.index)
            
                // 前画面に戻る
                self.navigationController?.popViewController(animated: true)
        })
        // キャンセルボタンの生成
        let cancelButton: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
                // 何もしない
        })
        
        // ③ UIAlertControllerにアクション（キャンセルボタン・OKボタン）を追加
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        
        // ④ アラートダイアログを表示
        self.present(alert, animated: true, completion: nil)
    }
    
}
