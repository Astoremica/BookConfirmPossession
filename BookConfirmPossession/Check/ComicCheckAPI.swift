//
//  ComicCheckAPI.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/28.
//
import  UIKit



class ComicCheckAPI {
    
    
    // 検索メソッド
    func searchComic(code:String){
        
        let global = Global()
//        let semaphore = DispatchSemaphore(value: 0)
//        
//        // let userDefaults = UserDefaults.standard
//        // リクエストURL組み立て
//        guard let req_url = URL(string:"https://api.openbd.jp/v1/get?isbn=\(code)&pretty") else {
//            return
//        }
//        print(req_url)
//        
//        // リクエストに必要な情報を生成
//        let req = URLRequest(url: req_url)
//        // データ転送を管理するためのセッションを生成
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        // リクエストをタスクとして登録
//        let task = session.dataTask(with: req,completionHandler: {(data,response,error) in
//            // セッション終了
//            session.finishTasksAndInvalidate()
//            // do try catch　エラーハンドリング
//            do{
//                let jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
//                let jsonData = jsonArray.map { (jsonData) -> [String: Any] in
//                    return jsonData as! [String: Any]
//                }
//                let summaryData = jsonData[0]["summary"].map { (summaryData) -> [String: Any] in
//                    return summaryData as! [String: Any]
//                }
//                //                let mode = userDefaults.string(forKey: "mode")
//                let title = summaryData!["title"] as! String
//                let pubdate = summaryData!["pubdate"] as! String
//                let cover = summaryData!["cover"] as! String
//                
//                // 読み取った書籍の情報
//                
//                global.comic =  ["title" : title , "pubdate" : pubdate , "cover" : cover ]
//                
//                
//                semaphore.signal()
//            
//                
//            }catch let error {
//                print(error)
//            }
//        })
//
//        task.resume()
//        semaphore.wait()
    
    }
    
    
    
}

