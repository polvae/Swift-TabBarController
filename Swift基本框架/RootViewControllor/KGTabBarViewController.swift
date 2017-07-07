//
//  KGTabBarViewController.swift
//  请求类
//
//  Created by KingSoft on 2017/7/6.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

/**
 *  button 图片与文字上下占比
 */
private let scale:CGFloat = 0.55

/**
 *  title默认颜色
 */
private let ColorTitle = UIColor.gray

/**
 *  title选中颜色
 */
private let ColorTitleSel = ColorRGB(41,g: 167,b: 245)

/**
 *  title字体大小
 */
private let titleFontSize : CGFloat = 12.0

/**
 *  数字角标直径
 */
private let numMarkD:CGFloat = 20.0

/**
 *  小红点直径
 */
private let pointMarkD:CGFloat = 12.0


//MARK: - UITabBarController -

class KGTabBarViewController: UITabBarController {
    var seleBtn:UIButton?
    var tabbarHeight:CGFloat = 49.0
    var titleArr = [String]()
    var imageArr = [String]()
    var selImageArray = [String]()
    var controllerArray = [String]()
    
    init(controllerArr: [String], titleArray: [String] , imageArr: [String] ,seleImageArr: [String] ,height: CGFloat?) {
        
        self.controllerArray = controllerArr
        self.titleArr = titleArray
        self.imageArr = imageArr
        self.selImageArray = seleImageArr
        
        if height != nil{
            tabbarHeight = height!
        }
        if tabbarHeight < 49.0
        {
            tabbarHeight = 49.0
        }
        super.init(nibName: nil, bundle: nil)

    }
    
    
    
    init() {
        /*
         控制器name数组
         */
        self.controllerArray = ["PositionViewController","TwoViewController","PositionViewController","ThreeViewController"]
        /*
         title数组
         */
        self.titleArr = ["首页","消息","朋友","我的"]
        /*
         默认图片数组
         */
        self.imageArr = ["home_tabbar","msg_tabbar","friend_tabbar","me_tabbar"]
        /*
         选中图片数组
         */
        self.selImageArray = ["home_tabbar_sel","msg_tabbar_sel","friend_tabbar_sel","me_tabbar_sel"]
        /*
         tabbar高度最小值49.0, 传nil或<49.0均按49.0处理
         */
        self.tabbarHeight = CGFloat(49)
        
        super.init(nibName: nil, bundle: nil)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addController()
        self.tabBar.addSubview(cusTabbar)
        addTabBarButton()
        setupTabbarLine()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeTabBarButton()
    }
    
    //MARK: - addController -
    func addController(){
        
        guard controllerArray.count > 0 else
        {
            print("error:控制器数组为nil")
            return
        }
        
        var navArray = [UIViewController]()
        //获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        
        for (index, className) in controllerArray.enumerated() {
            
            // 将类名转化为类
            let cls: AnyClass? = NSClassFromString(ns + "." + className)
            //Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
            guard let vcCls = cls as? UIViewController.Type else
            {
                print("error:\(className)不能当做UIViewController")
                return
            }
            let vc = vcCls.init()
            vc.title = titleArr[index]
            let nav = KGNavViewController(rootViewController:vc)
            navArray.append(nav)
        }
        
        viewControllers  = navArray;
    }
    
    //MARK: - addTabBarButton -
    func addTabBarButton(){
        
        let num = controllerArray.count
        for i in 0..<num{
            let width = screenW
            let x = width / CGFloat(num) * CGFloat(i)
            let  y:CGFloat = 0.0
            let  w = width/CGFloat(num)
            let  h = tabbarHeight
            let button = KGTabBarButton(frame: CGRect(x: x, y: y, width: w, height: h))
            button.tag = 1000 + i
            button.setTitleColor(ColorTitle, for: UIControlState.normal)
            button.setTitleColor(ColorTitleSel, for: UIControlState.selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: titleFontSize)
            button.setImage(UIImage.init(named: self.imageArr[i]), for: UIControlState.normal)
            button.setImage(UIImage.init(named: self.selImageArray[i]), for: UIControlState.selected)
            button.setTitle(titleArr[i], for: UIControlState.normal)
            button.addTarget(self, action:#selector(buttonAction(_:)), for: UIControlEvents.touchUpInside)
            
            cusTabbar.addSubview(button)
            
            if i == 0{
                button.isSelected = true
                self.seleBtn = button
            }
            
            //角标
            let numLabel = UILabel(frame: CGRect(x: button.frame.size.width/2.0+6, y: 3, width: numMarkD, height: numMarkD))
            numLabel.layer.masksToBounds = true
            numLabel.layer.cornerRadius = 10
            numLabel.backgroundColor = UIColor.red
            numLabel.textColor = UIColor.white
            numLabel.textAlignment = NSTextAlignment.center
            numLabel.font = UIFont.systemFont(ofSize: 13)
            numLabel.tag = 1020+i
            numLabel.isHidden = true
            button.addSubview(numLabel)
            
        }
    }
    
    //MARK: - setupTabbarLine -
    func setupTabbarLine(){
        guard tabbarHeight > 49 else {
            return
        }
        self.tabBar.shadowImage = UIImage.init()
        self.tabBar.backgroundImage = UIImage.init()
        let line = UILabel(frame: CGRect(x: 0, y: 0,width: screenW, height: 0.5))
        line.backgroundColor = UIColor.lightGray
        cusTabbar.addSubview(line)
        
    }
    
    
    //MARK: - clickAction-
    func buttonAction(_ button: UIButton) {
        let index: Int = button.tag - 1000
        self.showControllerIndex(index)
    }
    
    //MARK: - lazy init -
    lazy var cusTabbar: UIView = {
        
        let x = CGFloat(0)
        let y = 49.0 - self.tabbarHeight
        let width =  screenW
        let height = self.tabbarHeight
        let view = UIView(frame:CGRect(x: x,y: y,width: width,height: height))
        view.backgroundColor = UIColor.white
        return view
        
    }()
    
    //MARK: -  移除系统创建的UITabBarButton
    
    fileprivate func removeTabBarButton()
    {
        for view in tabBar.subviews {
            if view.isKind(of: NSClassFromString("UITabBarButton")!) {
                view.removeFromSuperview()
            }
        }
        
    }
}

//MARK: - TabBarButton
class KGTabBarButton:UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let newX:CGFloat = 0.0
        let newY:CGFloat = 5.0
        let newWidth:CGFloat = CGFloat(contentRect.size.width)
        let newHeight:CGFloat = CGFloat(contentRect.size.height)*scale-newY
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let newX: CGFloat = 0
        let newY: CGFloat = contentRect.size.height*scale
        let newWidth: CGFloat = contentRect.size.width
        let newHeight: CGFloat = contentRect.size.height-contentRect.size.height*scale
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }
    
    
}



//MARK: - extension KGTabBarViewController -

extension KGTabBarViewController{
    /**
     *  切换显示控制器
     *
     *  - param: index 位置
     */
     func showControllerIndex(_ index: Int) {
        
        guard index < controllerArray.count else
        {
            print("error:index="+"\(index)"+"超出范围")
            return;
        }
        self.seleBtn!.isSelected = false
        let button = (cusTabbar.viewWithTag(1000+index) as? UIButton)!
        button.isSelected = true
        self.seleBtn = button
        self.selectedIndex = index
    }
    
    /**
     *  设置数字角标
     *
     *  - param: num   所要显示数字
     *  - param: index 位置
     */
    func showBadgeMark(_ badge: Int, index: Int) {
        
        guard index < controllerArray.count else
        {
            print("error:index="+"\(index)"+"超出范围")
            return;
        }
        
        let numLabel = (cusTabbar.viewWithTag(1020+index) as? UILabel)!
        numLabel.isHidden = false
        var nFrame = numLabel.frame
        if badge <= 0 {
            //隐藏角标
            self.hideMarkIndex(index)
            
        } else {
            
            if badge > 0 && badge <= 9 {
                
                nFrame.size.width = numMarkD
                
            } else if badge > 9 && badge <= 19 {
                
                nFrame.size.width = numMarkD+5
                
            } else {
                
                nFrame.size.width = numMarkD+10
                
            }
            nFrame.size.height = numMarkD
            numLabel.frame = nFrame
            numLabel.layer.cornerRadius = numMarkD/2.0
            numLabel.text = "\(badge)"
            if badge > 99 {
                numLabel.text = "99+"
            }
            
        }
    }
    
    /**
     *  设置小红点
     *
     *  - param: index 位置
     */
    public func showPointMarkIndex(_ index: Int) {
        guard index < controllerArray.count else
        {
            print("error:index="+"\(index)"+"超出范围")
            return;
        }
        let numLabel = (cusTabbar.viewWithTag(1020+index) as? UILabel)!
        numLabel.isHidden = false
        var nFrame = numLabel.frame
        nFrame.size.height = pointMarkD
        nFrame.size.width = pointMarkD
        numLabel.frame = nFrame
        numLabel.layer.cornerRadius = pointMarkD/2.0
        numLabel.text = ""
    }
    
    /**
     *  影藏指定位置角标
     *
     *  - param: index 位置
     */
    public func hideMarkIndex(_ index: Int) {
        guard index < controllerArray.count else
        {
            print("error:index="+"\(index)"+"超出范围")
            return;
        }
        let numLabel = (cusTabbar.viewWithTag(1020+index) as? UILabel)!
        numLabel.isHidden = true
    }
    
}





