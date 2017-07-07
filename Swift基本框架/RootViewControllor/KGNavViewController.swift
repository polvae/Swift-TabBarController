//
//  KGNavViewController.swift
//  请求类
//
//  Created by KingSoft on 2017/7/7.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

class KGNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏系统自带的navigationBar
        navigationBar.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// 监听控制器的push操作 所有的 push 操作都会调用这个方法
    // viewController 是被 push进来，再次可以设置其返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器就需要隐藏，根控制器不需要处理
        if childViewControllers.count>0 {
            
            // 隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? KGBaseViewController{
                
                var title = "返回"
                
                // 判断如果是栈底控制器 即只有一个子控制器 显示栈底控制器的主题
                if childViewControllers.count==1 {
                    
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 设置控制器左侧栏的按钮 取出 navItem
                //可以是文字  or
                //文字
                //vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle(rawValue: 0)!, target: self, action: #selector(popToParent))
                //图标
                vc.navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "myBack"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popToParent))
            }
            
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func popToParent() {
        
        popViewController(animated: true)
        
    }
    
}

