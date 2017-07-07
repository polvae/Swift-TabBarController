//
//  TwoViewController.swift
//  请求类
//
//  Created by KingSoft on 2017/7/7.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(pushBtn)
        
    }

    lazy var pushBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        button.center = self.view.center
        button.backgroundColor = UIColor.gray
        button.setTitle("下一级", for: UIControlState.normal)
        button.addTarget(self, action: #selector(pushAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    func pushAction(){
        let ctl = UIViewController.init()
        ctl.view.backgroundColor = UIColor.white
        
//        self.navigationController?.pushViewController(ctl, animated: true)
        let tab: KGTabBarViewController =   self.view.window?.rootViewController as! KGTabBarViewController
        tab.showControllerIndex(3)
        tab.showPointMarkIndex(3)
        tab.showBadgeMark(5, index: 0)
        tab.hideMarkIndex(1)
    }

}
