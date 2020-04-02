//
//  DetailViewController.swift
//  TheSimpsonsApp
//
//  Created by Field Employee on 3/31/20.
//  Copyright © 2020 Tom Kew-Goodale. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: UIViewController {



    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var infoField: UILabel!
    @IBOutlet weak var imageField: UIImageView!
   
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = infoField {
                label.text = detail.Description
            }
            if let label = nameField {
                label.text = detail.name
            }
            if let label = imageField{
                let url = URL(string: detail.Image)
                guard let urlfordata = url else {return}
                if let data = try? Data(contentsOf: urlfordata){
                    label.image = UIImage(data: data)
                    }
                }
                
                
          
           

    }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        configureView()
        
        
    }

    var detailItem: characterLIB? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

