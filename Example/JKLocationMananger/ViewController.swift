//
//  ViewController.swift
//  JKLocationMananger
//
//  Created by xindizhiyin2014 on 03/19/2019.
//  Copyright (c) 2019 xindizhiyin2014. All rights reserved.
//

import UIKit
import JKLocationMananger

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
//        JKLocationMananger.locate(success: { (a, b) in
//            print(a!)
//            print(b!)
//        }, failure: { (error) in
//            print(error!)
//        })
//        JKLocationMananger.locate(success: { (city) in
//          print(city!)
//        }, failure: { (error) in
//            print(error!)
//        })
       Tool.location()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

