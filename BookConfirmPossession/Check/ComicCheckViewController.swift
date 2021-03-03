//
//  ComicCheckViewController.swift
//  BookConfirmPossession
//
//  Created by YoNa on 2021/02/26.
//


import UIKit
import AVFoundation




class ComicCheckViewController: UIViewController {
    
    var avCaptureSession: AVCaptureSession!
    var avPreviewLayer: AVCaptureVideoPreviewLayer!
    
    
    let global = Global()
    let comicCheck = ComicCheckAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        if traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = UIColor(displayP3Red: 85/255, green: 85/255, blue: 85/255,alpha: 1.0)
            
        }else{
            view.backgroundColor = UIColor(displayP3Red: 241/255, green: 241/255, blue: 241/255,alpha: 1.0)
        }
        avCaptureSession = AVCaptureSession()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                self.failed()
                return
            }
            let avVideoInput: AVCaptureDeviceInput
            
            do {
                avVideoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                self.failed()
                return
            }
            
            if (self.avCaptureSession.canAddInput(avVideoInput)) {
                self.avCaptureSession.addInput(avVideoInput)
            } else {
                self.failed()
                return
            }
            
            let metadataOutput = AVCaptureMetadataOutput()
            
            if (self.avCaptureSession.canAddOutput(metadataOutput)) {
                self.avCaptureSession.addOutput(metadataOutput)
                
                metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .qr]
            } else {
                self.failed()
                return
            }
            
            self.avPreviewLayer = AVCaptureVideoPreviewLayer(session: self.avCaptureSession)
            let height = self.view.bounds.height
            let width = self.view.bounds.width
            self.avPreviewLayer.frame = CGRect(x:0, y: 0, width: width, height: height)
            self.avPreviewLayer.videoGravity = .resizeAspectFill
            self.view.layer.addSublayer(self.avPreviewLayer)
            
            // 赤枠
            let cameraRedLine = CALayer()
            cameraRedLine.frame = CGRect(x:0, y: 330, width: width, height: 200)
            cameraRedLine.cornerRadius = 5
            cameraRedLine.borderColor = UIColor.red.cgColor
            cameraRedLine.borderWidth = 2
            cameraRedLine.backgroundColor = UIColor.clear.cgColor
            self.view.layer.addSublayer(cameraRedLine)
            
            // 赤枠内にバーコードのラベル
            let lineText = UILabel()
            lineText.frame = CGRect(x:0, y: 530, width: width, height: 50)
            lineText.text = "赤枠内にバーコードを入れてください"
            lineText.textAlignment = NSTextAlignment.center
            lineText.textColor = UIColor.red
            lineText.layer.backgroundColor = UIColor.white.cgColor
            lineText.font = UIFont(name:"Hiragino Maru Gothic ProN W4", size: 20)
            lineText.layer.backgroundColor = UIColor.clear.cgColor
            self.view.addSubview(lineText)
            
            
            self.avCaptureSession.startRunning()
        }
    }
    
    
    func failed() {
        let ac = UIAlertController(title: "カメラへのアクセス許可が必要です。", message: "書籍を読み取るためには、カメラへのアクセスを許可する必要があります。", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "設定", style: .default, handler: {action in
            // open the app permission in Settings app
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        ac.addAction(cancelAction)
        ac.addAction(settingsAction)
        present(ac, animated: true)
        avCaptureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (avCaptureSession?.isRunning == false) {
            avCaptureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (avCaptureSession?.isRunning == true) {
            avCaptureSession.stopRunning()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}
extension ComicCheckViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        avCaptureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            // 読み取れた時
            let code:String = stringValue
            
            let start = code.startIndex
            
            if code[start] == "9" {
                
                
                let storyboard: UIStoryboard = UIStoryboard(name: "ComicCheckResult", bundle: nil)//遷移先のStoryboardを設定
                let nextView = storyboard.instantiateViewController(withIdentifier: "comicCheckResult") as! ComicCheckResultViewController
                nextView.barCode = code
                self.navigationController?.pushViewController(nextView, animated: true)
                
                
            }else{
                // もう一つ上のバーコード
                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // OKボタンで再スキャン
                    self.avCaptureSession.startRunning()
                }
                showAlert(title: "スキャンミスです", message: "もう一つ上のバーコードです", actions: [okAction])
                
                //                let width = self.view.bounds.width
                //                let lineText = UILabel()
                //                lineText.frame = CGRect(x:0, y: 280, width: width, height: 50)
                //                lineText.text = "もう一つ上のバーコードです"
                //                lineText.textAlignment = NSTextAlignment.center
                //                lineText.textColor = UIColor.red
                //                lineText.layer.backgroundColor = UIColor.white.cgColor
                //                lineText.font = UIFont(name:"Hiragino Maru Gothic ProN W4", size: 24)
                //                lineText.layer.backgroundColor = UIColor.clear.cgColor
                //                self.view.addSubview(lineText)
                
            }
            
        }
        
        //        dismiss(animated: true)
    }
}
//
