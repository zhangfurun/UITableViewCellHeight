//
//  ViewController.swift
//  UITableViewCellHeight
//
//  Created by SnoHo on 2017/6/27.
//  Copyright © 2017年 SnoHo. All rights reserved.
//

import UIKit

class aViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    var entitys:[FeedEntity] = []
    
    var cellHeightCacheEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildTestDataThen { () -> () in
            
            
            self.tableView.reloadData()
            
        }
    }
    
    
    func buildTestDataThen(_ finish:(()->())?){
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async { () -> Void in
            
            guard let dataFilePath = Bundle.main.path(forResource: "data", ofType: "json") else {return}
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: dataFilePath)) else { return }
            var rootDict:NSDictionary!
            do{
                
                rootDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                
            }catch let err{
                print(err)
            }
            
            let feedDicts = rootDict["feed"] as! [NSDictionary]
            var entities = [FeedEntity]()
            feedDicts.forEach({ (dic) -> () in
                
                entities.append(FeedEntity(dic: dic))
                
            })
            print(entities)
            self.entitys = entities
            DispatchQueue.main.async(execute: { () -> Void in
                finish?()
            })
        }
        
    }
}

extension aViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedTableViewCell
        cell.entity = self.entitys[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entitys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.heightForCellWidth("FeedCell", configuration: { (cell) in
            guard let cell = cell as? FeedTableViewCell else {return }
            cell.entity = self.entitys[indexPath.row]
            
        })
    }
}

