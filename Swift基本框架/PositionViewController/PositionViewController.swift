//
//  PositionViewController.swift
//  Swift基本框架
//
//  Created by KingSoft on 2017/7/7.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PositionViewController: KGBaseViewController {
        var dataArr:[PositionModel] = []
        var tableView:UITableView!
        let  KBannerHeight = screenW / 375 * 185
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setUI()
            requestDate()
            
        }
        
    }
    
extension PositionViewController{
        
        func setUI(){
            self.tableView=UITableView(frame: CGRect(x: 0.0, y: 64, width: self.view.width, height:screenH - 64 - 49 ), style:.plain)
            self.view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 120
            
            tableView.separatorStyle  = UITableViewCellSeparatorStyle.none
            tableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil) , forCellReuseIdentifier: "mycell")
            let headerView = UIImageView(image: UIImage(named: "banner" ))
            headerView.frame = CGRect(x: 0, y: 0, width: tableView.width, height: KBannerHeight)
            tableView.tableHeaderView = headerView
            
        }
    }
    
    
extension PositionViewController{
        func requestDate() {
            let urlStr = "http://www.jucai360.com/MO/zwss.aspx"
            let params = ["Uid":"",
                          "Ddid":"430100",
                          "Hyid":"",
                          "Zwid":"",
                          "Zwmc":"",
                          "Xzq":"",
                          "Xzz":"",
                          "Gzfs":"",
                          "Fbsx":"",
                          "page":"1"]
            
            NetworkRequest.sharedInstance.getRequest(urlString: urlStr, params: params, success: { (returnResult) in
                
                let json = JSON(returnResult)["resultSet"]
                for dic in json.array!{
                    let model = PositionModel()
                    model.setValuesForKeys(dic.dictionaryObject!)
                    self.dataArr.append(model)
                }
                self.tableView.reloadData()
            }) { (error) in
                
            }
        }
        
    }
    
extension PositionViewController: UITableViewDelegate,UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.dataArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:PositionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! PositionTableViewCell
            cell.refreshUI(model: self.dataArr[indexPath.row])
            return cell
        }
        
        
        
}

