//
//  HomeTabBarViewController.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 05/01/15.
//  Copyright (c) 2015 MNT Developpement. All rights reserved.
//

import UIKit

class HomeTabBarViewController: RAMAnimatedTabBarController {

    var projectsButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let projectsImage = UIImage(named: "ProjectsIcon")!
        
        projectsButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
//        projectsButton.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: projectsImage.size)
        projectsButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        projectsButton.setBackgroundImage(projectsImage, forState: .Normal)
        
//        projectsButton.center = CGPoint(x: self.tabBar.center.x, y: self.tabBar.center.y - self.tabBar.frame.origin.y - (projectsImage.size.height - self.tabBar.frame.size.height) / 2.0)
        
        projectsButton.center = CGPoint(x: 250, y: 250)
        
        self.view.addSubview(projectsButton)
        

        
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.tabBar, attribute: .CenterY, multiplier: 1, constant: -projectsImage.size.height / 3))
    }
    
    /*

    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
    button.center = self.tabBar.center;
    else
    {
    CGPoint center = self.tabBar.center;
    center.y = center.y - heightDifference/2.0;
    button.center = center;
    }
    
    [self.view addSubview:button];


*/
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
