//
//  ViewController.swift
//  JY_ProgressView
//
//  Created by huangguojian on 2017/5/4.
//  Copyright © 2017年 formssi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func btnClick1(_ sender: Any) {
        self.view.showProgressView(message: "提示")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
            self.view.hideProgressView(message: nil)
        }
    }
    @IBAction func btnClick2(_ sender: Any) {
        self.view.showProgressView(message: "提示")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.hideProgressView(message: "错误提示")
        }
    }
    @IBAction func btnClick3(_ sender: Any) {
        self.view.showProgressView(message: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.hideProgressView(message: nil)
        }
    }
    @IBAction func btnClick4(_ sender: Any) {
        self.view.showProgressView(message: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.hideProgressView(message: "错误提示")
        }
    }
}

