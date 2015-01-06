//
//  FirstViewController.swift
//  MNTApp
//
//  Created by Mehdi Sqalli on 17/12/14.
//  Copyright (c) 2014 MNT Developpement. All rights reserved.
//

import UIKit

//
// Util delay function
//
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class FirstViewController: UIViewController, UIGestureRecognizerDelegate {

    let messages = ["Loading the projects...", "Projects Loaded"]
    
    var logoAlpha:CGFloat = 1.0
    
    let transitionDelegate = TransitionDelegate()
    
    @IBOutlet weak var bannerXConstraint: NSLayoutConstraint!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var leadingButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var alignCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var alignCenterButton: NSLayoutConstraint!
    @IBOutlet weak var mntLogo: UIImageView!
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var porscheImage: UIImageView!
    @IBOutlet weak var telCiteImage: UIImageView!
    @IBOutlet weak var PDMImage: UIImageView!
    @IBOutlet weak var JFImage: UIImageView!
    @IBOutlet weak var WWImage: UIImageView!
    @IBOutlet weak var happNowImage: UIImageView!
    @IBOutlet weak var barbanelImage: UIImageView!
    @IBOutlet weak var nexityImage: UIImageView!
    
    let gesture:UITapGestureRecognizer = UITapGestureRecognizer()
    
    lazy var logos:[UIImageView] = self.initLogos()
    
    func initLogos() -> [UIImageView] {
        return [porscheImage, telCiteImage, PDMImage, JFImage, WWImage, happNowImage, barbanelImage, nexityImage]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        enterButton.layer.cornerRadius = 6
        banner.addSubview(message)
        
        gesture.addTarget(self, action: "logoClicked")
        gesture.numberOfTouchesRequired = 1
        gesture.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        alignCenterYConstraint.constant -= view.bounds.height
        alignCenterButton.constant -= 30
        enterButton.alpha = 0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.alignCenterYConstraint.constant += self.view.bounds.height
            self.mntLogo.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            
            self.alignCenterButton.constant += 30
            self.enterButton.layoutIfNeeded()
            self.enterButton.alpha = 1
            
        }) { (finished) -> Void in
            
            self.launchLogos()
            
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "goHomeVC" {
            
            let homeVC = segue.destinationViewController as HomeTabBarViewController
            homeVC.transitioningDelegate = transitionDelegate
            homeVC.modalPresentationStyle = .Custom
            
        }
        
    }
    
    func hideLogos() {
        
        logoAlpha = 0.0
        
        for logo in logos {
            
            UIView.animateWithDuration(0.9, delay: 0, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                
                logo.alpha = self.logoAlpha
                
            }, completion: nil)
            
        }
    }
    
    func launchLogos() {
        let range = view.frame.height / (CGFloat(logos.count) * 2)
        
        var index = 0
        for logo in logos {
            logo.setTranslatesAutoresizingMaskIntoConstraints(true)
            
            let maxX = CGFloat(arc4random_uniform(UInt32(view.frame.width)))
            let maxY = randomInt(min(max(index * Int(range) + 20, 0), Int(self.view.frame.height - logo.frame.height)), max: (index + 1) * Int(range))
            logo.frame = CGRect(origin: CGPoint(x: maxX, y: CGFloat(maxY)), size: logo.frame.size)
            
            index += 2
            
            animateLogo(logo)
        }
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func showMessages(#index:Int) {
        
        UIView.animateWithDuration(0.35, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            
            self.bannerXConstraint.constant -= self.view.frame.width
            self.banner.layoutIfNeeded()
            
            }) { (finished) -> Void in
                
                self.banner.hidden = true
                self.bannerXConstraint.constant += self.view.frame.width
                self.message.text = self.messages[index]
                
                self.banner.layoutIfNeeded()
                
                UIView.transitionWithView(self.banner, duration: 0.3, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.TransitionCurlDown, animations: { () -> Void in
                    
                    self.banner.hidden = false
                    
                    
                }, completion: { (finished) -> Void in
                    
                    delay(seconds: 1.3, { () -> () in
                        
                        if index < self.messages.count - 1 {
                            self.showMessages(index: index + 1)
                        } else {
                            self.shrinkEnter()
                        }
                        
                    })
                    
                })
        }
        
    }
    
    func shrinkEnter() {
        UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.spinner.transform = CGAffineTransformMakeScale(1, 0.000001)
            self.banner.transform = CGAffineTransformMakeScale(1, 0.000001)
            self.message.transform = CGAffineTransformMakeScale(1, 0.000001)
            self.enterButton.transform = CGAffineTransformMakeScale(1, 0.000001)
            
            }, completion: nil)
        
        self.hideLogos()
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: { () -> Void in
            self.alignCenterYConstraint.constant = 0
            self.mntLogo.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                self.mntLogo.addGestureRecognizer(self.gesture)
                self.heartBeatLogo()
        })
    }
    
    func logoClicked() {
        println("logoClicked")
        
        self.performSegueWithIdentifier("goHomeVC", sender: self)
    }
    
    func heartBeatLogo() {
        UIView.animateWithDuration(0.2, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            
            self.mntLogo.transform = CGAffineTransformMakeScale(1.1, 1.1)
        
        }) { (finished) -> Void in
            
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                
                self.mntLogo.transform = CGAffineTransformMakeScale(1, 1)
                
            }, completion: { (finished) -> Void in
                self.heartBeatLogo()
            })
            
            
        }
    }
    
    @IBAction func enterClicked(sender: AnyObject) {
        
        self.enterButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 20, options: nil, animations: { () -> Void in
            
            self.leadingButtonConstraint.constant -= 50
            self.trailingButtonConstraint.constant += 50
            self.enterButton.layoutIfNeeded()
            
        }) { (finished) -> Void in
            
            
            self.showMessages(index: 0)
            
            
        }
        
        UIView.animateWithDuration(0.33, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.alignCenterButton.constant -= 50
            self.spinner.alpha = 1
            self.enterButton.backgroundColor = UIColor(red: 126.0/255.0, green: 79.0/255.0, blue: 128.0/255.0, alpha: 1.0)
            
            self.enterButton.layoutIfNeeded()
            self.spinner.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func animateLogo(logo: UIImageView) {

        var direction = arc4random_uniform(2)
        
        let logoSpeed = 12 / Double(view.frame.size.width)
        
        let duration: NSTimeInterval = direction == 0 ? Double(view.frame.size.width - logo.frame.origin.x) * logoSpeed : Double(logo.frame.origin.x + logo.frame.size.width) * logoSpeed
        
        logo.alpha = 0
        
        UIView.animateWithDuration(duration, delay: 0.0, options: .CurveLinear, animations: {
            
            logo.frame.origin.x = direction == 0 ? self.view.bounds.size.width : -logo.frame.size.width
            logo.layoutIfNeeded()
            logo.alpha = self.logoAlpha
            
            }, completion: {_ in

                logo.frame.origin.x = direction == 0 ? -logo.frame.size.width : self.view.frame.size.width
                self.animateLogo(logo)
        })
    }

}
