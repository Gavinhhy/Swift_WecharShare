//
//  ViewController.swift
//  Wechatshare
//
//  Created by Gavin on 16/3/30.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //发送给好友还是发送到朋友圈
    var _scene = Int32(WXSceneSession.rawValue)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    //新增方法
    //切换发送给好友还是朋友圈
    
    @IBAction func changeScene(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            _scene = Int32(WXSceneSession.rawValue)
        }else{
            _scene = Int32(WXSceneTimeline.rawValue)
        }
    }
    
    //发送文字
    @IBAction func sendTextContent(sender: UIButton) {
        print("发送文字")
        let req = SendMessageToWXReq()
        req.bText = true
        req.text = "swift 文本消息分享"
        req.scene = _scene
        WXApi.sendReq(req)
        
    }
    
    //发送图片
    @IBAction func sendImageContent(sender: UIButton) {
        print("发送图片")
        let message = WXMediaMessage()
        
        //要发送的图片
        let filePath = NSBundle.mainBundle().pathForResource("tiao1", ofType: "png")
        let image = UIImage(contentsOfFile: filePath!)
        let imageObject = WXImageObject()
        imageObject.imageData = UIImagePNGRepresentation(image!)
        message.mediaObject = imageObject
        
        //图片压缩
        let width = 240.0 as CGFloat
        let height = width*image!.size.height/image!.size.width
        UIGraphicsBeginImageContext(CGSizeMake(width,height))
        image!.drawInRect(CGRectMake(0, 0, width, height))
        message.setThumbImage(UIGraphicsGetImageFromCurrentImageContext())
        UIGraphicsEndImageContext()
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    
    //发送链接
    @IBAction func sendLinkContent(sender: UIButton) {
        print("发送链接")
        let message = WXMediaMessage()
        
        message.title = "微信分享 swift"
        message.description = "这是一个关于swift版本的微信分享的测试"
        message.setThumbImage(UIImage(named: "tiao1.png"))
        
        let ext = WXWebpageObject()
        ext.webpageUrl = "http://happysoft.cc"
        message.mediaObject = ext
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    
    //发送音乐
    @IBAction func sendMusicContent(sender: AnyObject) {
        print("发送音乐")
        
        let message =  WXMediaMessage()
        
        message.title = "一无所有"
        message.description = "崔健"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXMusicObject()
        ext.musicUrl = "http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4B880E697A0E68980E69C89222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696334382E74632E71712E636F6D2F586B30305156342F4141414130414141414E5430577532394D7A59344D7A63774D4C6735586A4C517747335A50676F47443864704151526643473444442F4E653765776B617A733D2F31303130333334372E6D34613F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D30222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31342E71716D757369632E71712E636F6D2F33303130333334372E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E4B880E697A0E68980E69C89222C22736F6E675F4944223A3130333334372C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E5B494E581A5222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D313574414141416A41414141477A4C36445039536A457A525467304E7A38774E446E752B6473483833344843756B5041576B6D48316C4A434E626F4D34394E4E7A754450444A647A7A45304F513D3D2F33303130333334372E6D70333F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D3026616D703B73747265616D5F706F733D35227D"
        ext.musicDataUrl = "http://stream20.qqmusic.qq.com/32464723.mp3"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    //发送视频
    @IBAction func sendViewContent(sender: UIButton) {
        print("发送视频")
        let message =  WXMediaMessage()
        message.title = "乔布斯访谈"
        message.description = "乔布斯访谈视频。"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXVideoObject()
        ext.videoUrl = "http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    
    //发送非gif格式的表情
    @IBAction func sendNonGifContent(sender: AnyObject) {
        let message =  WXMediaMessage()
        message.setThumbImage(UIImage(named:"tiao1thumb.png"))
        
        let ext =  WXEmoticonObject()
        let filePath = NSBundle.mainBundle().pathForResource("tiao1", ofType: "jpg")
        ext.emoticonData = NSData(contentsOfFile:filePath!)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    
    //发送gif格式的表情
    @IBAction func sendGifContent(sender: AnyObject) {
        let message =  WXMediaMessage()
        message.setThumbImage(UIImage(named:"res6thumb.png"))
        
        let ext =  WXEmoticonObject()
        let filePath = NSBundle.mainBundle().pathForResource("res6", ofType: "gif")
        ext.emoticonData = NSData(contentsOfFile:filePath!)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)    }
    
    //发送文件
    @IBAction func sendFileContent(sender: AnyObject) {
        let message =  WXMediaMessage()
        message.title = "ML.pdf"
        message.description = "Pro CoreData"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXFileObject()
        ext.fileExtension = "pdf"
        let filePath = NSBundle.mainBundle().pathForResource("ML", ofType: "pdf")
        ext.fileData = NSData(contentsOfFile:filePath!)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.sendReq(req)
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

