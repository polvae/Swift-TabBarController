//
//  KGBaseViewController.swift
//  请求类
//
//  Created by KingSoft on 2017/7/7.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

class KGBaseViewController: UIViewController {
    
    /// 自定义导航条
    lazy var navigationBar : UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenW, height: 64))
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    /// Expected ')' in expression list 这种错误，说明括号少打了一个
    lazy var navItem : UINavigationItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 初始化
        setup()
        /// 初始化子控件
        setupSubViews()
        
    }
    
    /// 重写Setter方法
    override var title: String?{
        didSet{
            // 设置值
            navItem.title = title
        }
    }
    
}
// MARK: - 初始化
extension KGBaseViewController{
    
    fileprivate func setup() {
        
        view.backgroundColor = UIColor.white
        
        // 去除缩进，取消自动缩进 - 如果隐藏了导航栏，会缩进 20 个点
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
}

// MARK: - 设置自控制器
extension KGBaseViewController{
    
    fileprivate func setupSubViews(){
        
        // 设置导航栏
        setupNavigationBar()
    
    }
    
    /// 设置导航栏
    private func setupNavigationBar() {
        
        // 添加导航条
        view.addSubview(navigationBar)
        
        // 将item 设置给bar
        navigationBar.items = [navItem]
        
        // 设置navigationBar的 整个背景的颜色 渲染 （PS：否则导航条的透明太高，导致导航栏的右侧，有一块白色区域,即曝光太高）
        navigationBar.barTintColor = ColorWithHex(hex: 0xF6F6F6)
        
        // 设置 navigationBar 的字体颜色
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        
        // 设置导航栏文字按钮的渲染颜色
        navigationBar.tintColor = UIColor.darkGray
        
        // Tips : 勤提交
        
    }
    
    
    
}

