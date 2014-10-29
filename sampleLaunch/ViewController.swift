//
//  ViewController.swift
//  sampleLaunch
//
//  Created by Anthony Sherbondy on 10/28/14.
//  Copyright (c) 2014 iosfd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var blueView: UIView!
    var grayView: UIView!
    var isPresenting: Bool = true
    var isGoingToPink: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grayView = UIView(frame: blueView.frame)
        grayView.center.x += 100
        grayView.backgroundColor = UIColor(white: 0.5, alpha: 1)
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        
        var aView = UIImageView(frame: blueView.frame)
        aView.image = UIImage(named: "pig")
        aView.center = sender.locationInView(view)
        aView.alpha = 0
        view.addSubview(aView)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            aView.alpha = 1
        })
        
        performSegueWithIdentifier("goto_gray", sender: nil)
    }
    
    @IBAction func onButton(sender: AnyObject) {
        view.addSubview(grayView)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        if isPresenting {
            return 1.5
        } else {
            return 0.5
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if isPresenting {
            var window = UIApplication.sharedApplication().keyWindow
            var newBlue = UIView(frame: blueView.frame)
            newBlue.backgroundColor = blueView.backgroundColor
            newBlue.transform = CGAffineTransformMakeScale(1.2, 1.2)
            window.addSubview(newBlue)
            blueView.hidden = true
            
            containerView.addSubview(toViewController.view)
            toViewController.view.frame.origin = CGPoint(x: 320, y: 568)
            toViewController.view.transform = CGAffineTransformMakeScale(0, 0)
            
            var pinkViewController = toViewController as PinkViewController
            pinkViewController.blueView.hidden = true
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                
                newBlue.transform = CGAffineTransformIdentity
                newBlue.frame = pinkViewController.blueView.frame
                toViewController.view.transform = CGAffineTransformMakeScale(1, 1)
                toViewController.view.frame.origin = CGPoint(x: 0, y: 0)
                
                }, completion: { (finished: Bool) -> Void in
                newBlue.removeFromSuperview()
                pinkViewController.blueView.hidden = false
                transitionContext.completeTransition(true)
            })
        } else {
            blueView.hidden = false
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                fromViewController.view.transform = CGAffineTransformMakeScale(0.001, 0.001)
                
                }, completion: { (finished: Bool) -> Void in
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
    }
}

