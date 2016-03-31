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
    
    //分享文本
    func sendText(text:String, inScene: WXScene)->Bool{
        let req=SendMessageToWXReq()
        req.text=text
        req.bText=true
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    ///分享图片
    func sendImage(image:UIImage, inScene:WXScene)->Bool{
        let ext=WXImageObject()
        ext.imageData=UIImagePNGRepresentation(image)
        
        let message=WXMediaMessage()
        message.title=nil
        message.description=nil
        message.mediaObject=ext
        message.mediaTagName="MyPic"
        //生成缩略图
        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
        image.drawInRect(CGRectMake(0, 0, 100, 100))
        let thumbImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        message.thumbData=UIImagePNGRepresentation(thumbImage)
        
        let req=SendMessageToWXReq()
        req.text=nil
        req.message=message
        req.bText=false
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let shareTextToMoments:UIButton = UIButton(frame: CGRectMake(100,100
            ,200,30))
        shareTextToMoments.setTitleColor(UIColor.blackColor(),forState: .Normal)
        shareTextToMoments.setTitle("分享文本到朋友圈", forState: UIControlState.Normal)
        let shareImageToMoments:UIButton = UIButton(frame: CGRectMake(100,200,200,30))
        shareImageToMoments.setTitleColor(UIColor.blackColor(),forState: .Normal)
        shareImageToMoments.setTitle("分享图片到朋友圈", forState: UIControlState.Normal)
        self.view.addSubview(shareTextToMoments)
        self.view.addSubview(shareImageToMoments)
       
        shareTextToMoments.addTarget(self, action: Selector("textToMoments"), forControlEvents: UIControlEvents.TouchUpInside)
        
        shareImageToMoments.addTarget(self, action: Selector("imageToMoments"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    //定义点击方法
    func textToMoments(){
        sendText("这是一条swift版本的医道朋友圈分享", inScene: WXSceneTimeline) //分享文本到朋友圈
    }
    func imageToMoments(){
        sendImage(UIImage(named: "tiao1.png")!, inScene: WXSceneTimeline) //分享图片到朋友圈，假设项目中已经添加了一张名曰MyImage.png的大图片作为分享图片
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

