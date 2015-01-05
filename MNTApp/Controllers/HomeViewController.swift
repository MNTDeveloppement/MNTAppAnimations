//
//  HomeViewController.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 30/12/14.
//  Copyright (c) 2014 MNT Developpement. All rights reserved.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController {

//    let logo = UIImageView(image: UIImage(named: "MNTDev")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        logo.layer.position = CGPoint(x: view.layer.bounds.size.width / 2, y: view.layer.bounds.size.height / 2)
//        view.layer.mask = logo.layer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//       view.layer.mask = nil
    }
    
    @IBAction func logoutClicked(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
