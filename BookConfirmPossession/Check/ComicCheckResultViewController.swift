//
//  ComicCheckResultViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/01.
//

import UIKit
@IBDesignable


class ComicCheckResultViewController: UIViewController {
    
    let global = Global()
    let comicCheck = ComicCheckAPI()
    
    var comic: [String: String] = [:]
    
    // 読み込んだISBNコード用
    var barCode : String = ""
    
    // 購入したかどうか
    @IBOutlet weak var checkResultLabel: UILabel!
    // 表紙
    @IBOutlet weak var comicCoverImageView: UIImageView!
    // タイトル
    @IBOutlet weak var comicTitleLabel: UILabel!
    // 購入日
    @IBOutlet weak var comicPurchaseDate: UILabel!
    // 買うボタン未購入の時のみ
    @IBOutlet weak var comicPurechaseButton: NeumorphismButton!
    // 他の本、本の追加ボタン
    @IBOutlet weak var anotherComicButton: NeumorphismButton!
    
    
    var semaphore : DispatchSemaphore!
    
    
    override func viewDidLoad() {
        //        semaphore = DispatchSemaphore(value: 0)
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        
        //                let semaphore = DispatchSemaphore(value: 0)
        
        // let userDefaults = UserDefaults.standard
        // リクエストURL組み立て
        let url: URL = URL(string: "https://api.openbd.jp/v1/get?isbn=\(barCode)")!
        //        =================================
        print(url)
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            do  {
                //        // リクエストに必要な情報を生成
                //        let req = URLRequest(url: req_url)
                //        // データ転送を管理するためのセッションを生成
                //        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                //        // リクエストをタスクとして登録
                //        print("a")
                //        let task = session.dataTask(with: req,completionHandler: {
                //            (data,response,error) in
                //            print("c")
                //            // セッション終了
                //            session.finishTasksAndInvalidate()
                //            // do try catch　エラーハンドリング
                //            do{
                print("d")
                let jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                
                DispatchQueue.main.async {
                    let jsonData = jsonArray.map { (jsonData) -> [String: Any] in
                        return jsonData as! [String: Any]
                    }
                    let summaryData = jsonData[0]["summary"].map { (summaryData) -> [String: Any] in
                        return summaryData as! [String: Any]
                    }
                    
                    //                let mode = userDefaults.string(forKey: "mode")
                    let title = summaryData!["title"] as! String
                    let pubdate = summaryData!["pubdate"] as! String
                    let cover = summaryData!["cover"] as! String
                    
                    // 読み取った書籍の情報
                    
                    self.global.comic =  ["title" : title , "pubdate" : pubdate , "cover" : cover ]
                    if title != ""{
                        // タイトル
                        self.comicTitleLabel.text = title
                    }else{
                        self.comicTitleLabel.text = "取得できませんでした。"
                    }
                    // 表紙　なければNotFound画像
                    if cover != ""{
                        self.comicCoverImageView.downloaded(from:cover)
                    }else{
                        self.comicCoverImageView.image = UIImage(named: "notFoundCover")
                        
                    }
                    //                self.semaphore.signal()
                }
                
            }catch let error {
                print(error)
            }
            //                    semaphore.signal()
        })
        print("start")
        task.resume()
        //        semaphore.wait()
        
        
        
        
        
        //        self.comicCheck.searchComic(code: self.barCode)
        
        
        
        
        //        if let title =  comic["title"]{
        //            // タイトル
        //            comicTitleLabel.text = title
        //        }else{
        //            comicTitleLabel.text = "取得できませんでした。"
        //        }
        //        // 表紙　なければNotFound画像
        //        if let cover = comic["cover"]{
        //            comicCoverImageView.downloaded(from:cover)
        //        }else{
        //            comicCoverImageView.image = UIImage(named: "notFoundCover")
        //
        //        }
        
        //        let code:String = UserDefaults.standard.string(forKey: "barcode")!
        //
        //        let semaphore = DispatchSemaphore(value: 0)
        //        if let mode = userDefaults.string(forKey: "mode"){
        //            print("aaa")
        //            comicCheck.searchComic(code: code,mode: mode)
        //            semaphore.signal()
        //        }
        //        semaphore.wait()
        //        let comicArray = UserDefaults.standard.object(forKey: "comic") as? [String:String] ?? [String:String]
        //        let comic = (title: comicArray["title"], pubdate: comicArray["pubdate"], cover: comicArray["cover"])
        //
        //        print("bbb")
        //
        //        comicTitleLabel.text = comic.title
        //        print(comic.cover)
        //        if comic.cover != "" {
        //            comicCoverImageView.downloaded(from:comic.cover)
        //        }else{
        //            comicCoverImageView.image = UIImage(named: "notFoundCover")
        //        }
        //
        //        let checkmode = "add"
        //        userDefaults.set(checkmode, forKey: "mode")
        //        userDefaults.synchronize()
        //
        //
        //
        //
        //
        
    }
    
    
    @IBAction func addAnotherComicButtonAction(_ sender: Any) {
        // スキャン情報をマンガ一覧用の配列に追加
        global.comicList.append(comic)
        // スキャンした書籍情報を初期化
        comic.removeAll()
        // 読みとり画面へ戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

