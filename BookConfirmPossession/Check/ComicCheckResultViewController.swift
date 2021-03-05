//
//  ComicCheckResultViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/03/01.
//

import UIKit
import RealmSwift
@IBDesignable


class ComicCheckResultViewController: UIViewController {
    
    let global = Global()
    let userDefaults = UserDefaults.standard
    let functions = Functions()
    
    
    // 読み込んだISBNコード用
    var barCode : String = ""
    
    // imageLinkのデータ構造
    struct  ImageLinkJson: Codable {
        let smallThumbnail: String?
    }
    // JSONのItem内のデータ構造
    struct VolumeInfoJson: Codable {
        // 本の名称
        let title: String?
        // 著者
        let publishedDate : String?
        // 本の画像
        let imageLinks: ImageLinkJson?
    }
    // Jsonのitem内のデータ構造
    struct ItemJson: Codable {
        let volumeInfo: VolumeInfoJson?
    }
    
    // JSONのデータ構造
    struct ResultJson: Codable {
        // 複数要素
        let kind: String?
        let items: [ItemJson]?
    }
    
    
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
    
    
    var comicTitle:String?
    var comicCover:String?
    var comicPubdate:String?

    
    override func viewDidLoad() {
        //        semaphore = DispatchSemaphore(value: 0)
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        // タイトル自動縮小
        comicTitleLabel.adjustsFontSizeToFitWidth = true
        comicTitleLabel.minimumScaleFactor = 0.5
        
        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=isbn:\(barCode)") else {
            return
        }
        print(req_url)
        
        // リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        // データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        // リクエストをタスクとして登録
        let task = session.dataTask(with: req, completionHandler: { [self]
            (data , response , error) in
            // セッションを終了
            session.finishTasksAndInvalidate()
            // do try catch エラーハンドリング
            do {
                //JSONDecoderのインスタンス取得
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース(解析)して格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                if let comic = json.items?[0].volumeInfo{
                    self.comicTitle = comic.title ?? ""
                    self.comicCover = comic.imageLinks?.smallThumbnail ?? ""
                    self.comicPubdate = comic.publishedDate ?? ""
                }else{
                    // 情報が取得できない時
                    self.comicTitle =  "取得できませんでした"
                    Thread.sleep(forTimeInterval: 0.5)
                    self.comicCover = ""
                    self.comicPubdate =  "取得できませんでした"
                }
                self.comicTitleLabel.text = self.comicTitle
                if self.comicCover != ""{
                    self.comicCoverImageView.downloaded(from:self.comicCover!)
                }else{
                    // GoogleBooksAPIで表紙が入手できなかった場合の手段
                    self.comicCover = "https://cover.openbd.jp/\(barCode).jpg"
                    self.comicCoverImageView.downloaded(from:self.comicCover!)
                }
                global.comic = ["title":self.comicTitle ?? "","pubdate":self.comicPubdate ?? "","cover":self.comicCover!,"isbnCode":barCode]
                
                if var getComicList = userDefaults.array(forKey: "comics") as? [[String:String]] {
                    print(type(of: getComicList))
                    print(getComicList)
                    getComicList.append(global.comic)
                    userDefaults.set(getComicList, forKey: "comics")
                }else{
                    let getComicList :[[String:String]] = [global.comic]
                    userDefaults.set(getComicList, forKey: "comics")
                    
                }
                // スキャンした書籍情報を初期化
                global.comic.removeAll()
                
            } catch {
                // エラー処理
                print(error)
            }
        })
        // ダウンロード開始
        task.resume()
        
    }
    
    @IBAction func addAnotherComicButtonAction(_ sender: Any) {
        
        
//        if var getComicList = userDefaults.array(forKey: "comics") as? [[String:String]] {
//            print(type(of: getComicList))
//            print(getComicList)
//            getComicList.append(global.comic)
//            userDefaults.set(getComicList, forKey: "comics")
//        }else{
//            let getComicList :[[String:String]] = [global.comic]
//            userDefaults.set(getComicList, forKey: "comics")
//        }
//        // スキャンした書籍情報を初期化
//        global.comic.removeAll()
        // 読みとり画面へ戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanComicListBuyButton(_ sender: Any) {
        var comic: [String: Any] = [:]
        do {
            let realm = try Realm()
            let getComicList = userDefaults.array(forKey: "comics") as? [[String:String]]
            getComicList.map{
                for reco in $0{
                    print(reco["isbnCode"] as Any)
                    comic = [
                        "barBode" : reco["isbnCode"]!,
                        "comicInfo" :
                            ["comicTitle" : reco["title"],
                             "comicCover" : reco["cover"],
                             "comicPurchaseDate" : functions.getPurchaseDate()]
                    ]
                    let comic = Comics(value: comic)
                    
                    try! realm.write {
                        realm.add(comic)
                    }
                }
            }
        } catch {
            print(error)
        }
        let storyboard: UIStoryboard = UIStoryboard(name: "ScanComicSaveCompleted", bundle: nil)//遷移先のStoryboardを設定
        let nextView = storyboard.instantiateViewController(withIdentifier: "comicSaveCompleted") as! ScanComicSaveCompletedViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "toScanComicList" {
                let nextVC = segue.destination as! ScanComicListViewController
                nextVC.fromPage = 0
            }
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

