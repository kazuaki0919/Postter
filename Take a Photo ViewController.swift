//
//  Take a Photo ViewController.swift
//  Postter
//
//  Created by 並木一晃 on 2016/01/02.
//  Copyright © 2016年 並木一晃. All rights reserved.
//

import UIKit
import Social
import AVFoundation

class Take_a_Photo_ViewController: UIViewController {
    
    // 画像のアウトプット
    var myImageOutput:AVCaptureStillImageOutput!
    // 撮影した写真イメージ
    var stillImage:UIImage?
    
    // ツールバーのシェアボタン
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    // シェアボタンで実行する
    @IBAction func share(sender: AnyObject) {
        // 共有する項目
        let shareText = "testText"
        let shareItems = [shareText]
        
        let avc = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivity.ActivityType.postToFacebook,
            UIActivity.ActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.copyToPasteboard,
            UIActivityType.airDrop,
            UIActivityType.assignToContact,
            UIActivityType.addToReadingList,
            UIActivityType.mail,
            UIActivityType.message
        ]
        avc.excludedActivityTypes = excludedActivityTypes as? [String] as! [UIActivityType]
        
        present(avc, animated: true, completion: nil)
    }
    
    // シャッターボタンで実行する
    @IBAction func takePhoto(sender: AnyObject) {
        // ビデオ出力に接続する
        guard let myAVConnection = myImageOutput.connection(with: AVMediaType.video) else { return default value }
        
        // 接続から画像を取得する
        myImageOutput.captureStillImageAsynchronously(from: myAVConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            // ビデオ画像をキャプチャする
            let myImageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer ?? default value)
            self.stillImage = UIImage(data: myImageData ?? default value)
            
            // カメラロールに追加する
            UIImageWriteToSavedPhotosAlbum(self.stillImage!, self, nil, nil)
            // ツールバーのシェアボタンを有効にする
            self.shareButton.isEnabled = true
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
    
    // ツールバーのシェアボタンを無効にする
        shareButton.isEnabled = false
    
    // セッションの作成
    let mySession = AVCaptureSession()
    //解像度の指定
        mySession.sessionPreset = AVCaptureSession.Preset.high
    
    // 撮影に使うカメラ
    var myCamera:AVCaptureDevice!
    //デバイス一覧の取得
    let devices = AVCaptureDevice.devices()
    for device in devices{
    // バックカメラで撮影する
        if(device.position == AVCaptureDevice.Position.back){
    myCamera = device as! AVCaptureDevice
    }
    }
    
    // カメラからVideoInputを取得する
    do {
    // 入力元
    let videoInput = try AVCaptureDeviceInput(device: myCamera)
    mySession.addInput(videoInput)
    
    // 出力先
    myImageOutput = AVCaptureStillImageOutput()
    mySession.addOutput(myImageOutput)
    
    // 画像を表示するプレビューレイヤを作る
    let myVideoLayer = AVCaptureVideoPreviewLayer(session: mySession)
    myVideoLayer.frame = view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    // 最背面になるようにプレビューレイヤを挿入する
        view.layer.insertSublayer(myVideoLayer, at: 0)
    
    // セッション開始
    mySession.startRunning()
    
    } catch let error as NSError {
    print("カメラは使えません。\(error)")
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
