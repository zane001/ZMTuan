//
//  ViewController.swift
//  ZMTuan
//
//  Created by zm on 4/10/16.
//  Copyright © 2016 zm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIAlertController(title: "fuck", message: "you", preferredStyle: .Alert)
        vc.addAction(UIAlertAction(title: "lol", style: .Default, handler: nil))
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

