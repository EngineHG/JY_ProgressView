//
//  ProgressView.swift
//  依赖库：SnapKit
//  配置SnapKit可看博客 http://blog.csdn.net/q604362118/article/details/71191467
//  Created by JY on 2017/5/4.
//  Copyright © 2017年 JY. All rights reserved.
//

import UIKit
import SnapKit

//提示信息Label的高度
let messageLabelFontSize: CGFloat = 14

//progressView是否处于正在消失状态
var isHidding: Bool = false

//菊花的半透明背景
let bgView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.7)
    view.isHidden = true
    view.layer.cornerRadius = 10.0
    view.layer.masksToBounds = true

    return view
}()

//语言提示标签
let messageLabel: UILabel = {
    let lb: UILabel = UILabel()
    lb.textColor = UIColor.white
    lb.font = UIFont.systemFont(ofSize: messageLabelFontSize)
    return lb
}()

//菊花
let activityView: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView(activityIndicatorStyle:.whiteLarge)
    view.hidesWhenStopped = true
    return view
}()

extension UIView{
    
    /// 显示菊花
    ///
    /// - Parameter message: 菊花下面的提示信息
    public func showProgressView(message: String?){
        
        self.isUserInteractionEnabled = false;
        
        if !bgView.isDescendant(of: self){
            self.initView()
        }
        
        if bgView.isHidden {
            self.updateViewWhenShow(message: message)
            bgView.isHidden = false
            bgView.alpha = 1
            activityView.startAnimating()
        }
        
    }
    
    /// 隐藏菊花，并非remove
    ///
    /// - Parameter message: 菊花隐藏，显示message，然后过一定时间，整个ProgressView消失
    public func hideProgressView(message: String?){
        
        if isHidding {
            return
        }
        if message != nil && message?.characters.count != 0{
            
            self.updateViewWhenHide(message: message!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.hideProgressView()
            }
        }
        else{
            self.hideProgressView()
        }
        
        
    }
    
    //判断菊花是否在显示中
    public func isShowingProgressView() -> Bool{
        
        return bgView.isDescendant(of: self)
    }
    
    //判断菊花是否在消失中
    public func isHiddingProgressView() -> Bool{
        
        return isHidden
    }
    
    private func initView(){
        
        self.addSubview(bgView)
        bgView.addSubview(messageLabel)
        bgView.addSubview(activityView)
        
        bgView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(bgView.snp.width)
        }
        
        messageLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(messageLabelFontSize)
        }
        
        activityView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func updateViewWhenShow(message: String?){
       
        messageLabel.text = message
        
        let offset: CGFloat
        if  message != nil && message?.characters.count != 0 {
            
            offset = messageLabelFontSize
        }
        else{
            
            offset = 0
        }
        
        messageLabel.snp.updateConstraints{ (make) in
            make.centerY.equalToSuperview().offset((offset + 8))
        }
        
        activityView.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview().offset(-offset)
        }
        
        self.layoutIfNeeded()
    }
    
    private func updateViewWhenHide(message: String){
        
        messageLabel.text = message
        activityView.stopAnimating()
        
        messageLabel.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview()
        }
        
        self.layoutIfNeeded()
    
    }
    
    private func hideProgressView(){
        
        isHidding = true
        
        UIView.animate(withDuration: 0.5, animations: {
            
            bgView.alpha = 0
            
        }) {(isDone) in
            if isDone {
                
                bgView.isHidden = true
                isHidding = false
                self.isUserInteractionEnabled = true;
            }
        }
    }

}
