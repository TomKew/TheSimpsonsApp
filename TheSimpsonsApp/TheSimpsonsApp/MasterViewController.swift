//
//  MasterViewController.swift
//  TheSimpsonsApp
//
//  Created by Field Employee on 3/31/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    var charDic: [characterLIB] = [characterLIB]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        fillChar()

     
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

   
    
    func fillChar(){
        let urlHolder: URL = URL(string: "http://api.duckduckgo.com/?q=simpsons+characters&format=json")!
              
        let data = try! Data(contentsOf: urlHolder)
                 
        let json: JSON = JSON(data)
        let subJson = json["RelatedTopics"]
        for (_, value) in subJson{
            let simpson = characterLIB()
            let textHolder = value["Text"].stringValue
            let name = textHolder.components(separatedBy: "-")

            simpson.name = name[0]
            simpson.Description = name[1]
            simpson.Image = value["Icon"]["URL"].stringValue
            charDic.append(simpson)
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = charDic[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charDic.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = charDic[indexPath.row].name
        cell.textLabel!.text = object
        return cell
    }

}

