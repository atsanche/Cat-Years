//
//  ViewController.swift
//  Cat Years
//
//  Created by Abel Sanchez on 9/21/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit
import ImageSlideshow

extension UIView {
    
    // PUSH ANIMATION
    func pushTransitionUp(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionPush)
    }
    /*func pushTransitionDown(duration:CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransti
        animation.subtype = kCATransitionFromBottom
        animation.duration = duration
        self.layer.add(animation, forkey: kCATransitionPush)
    }*/
}

class ViewController: UIViewController {

    let numberToolbar:UIToolbar = UIToolbar()
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var textOutput: UILabel!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate?
    
    let localSource = [ImageSource(imageString: "img1")!, ImageSource(imageString: "img2")!, ImageSource(imageString: "img3")!, ImageSource(imageString: "img4")!]
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        print(textInput)
        if (textInput.text?.isEmpty)! {
            textOutput.pushTransitionUp(0.8)
        } else {
            var answer:Int = Int(textInput.text!)!
            answer = answer * 7
            
            textOutput.pushTransitionUp(0.6)
            textOutput.text = "\(answer) Years Old"
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // NUMBERPAD APPLY AND CANCEL
        numberToolbar.barStyle = UIBarStyle.blackTranslucent
        numberToolbar.items=[
            UIBarButtonItem(title:"Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ViewController.notAcceptButton)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.plain, target:self, action: #selector(ViewController.acceptButton))
        ]
        numberToolbar.sizeToFit()
        textInput.inputAccessoryView = numberToolbar
        
        // SLIDESHOW
        slideshow.backgroundColor = UIColor.clear
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.underScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideshow.setImageInputs(localSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.click))
        slideshow.addGestureRecognizer(recognizer)
        
    }
    
    func acceptButton () {
        textInput.resignFirstResponder()
    }
    

    func notAcceptButton () {
        textInput.text=""
        textInput.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func click() {
        let ctr = FullScreenSlideshowViewController()
        ctr.pageSelected = {(page: Int) in
            self.slideshow.setScrollViewPage(page, animated: false)
        }

        ctr.initialImageIndex = slideshow.scrollViewPage
        ctr.inputs = slideshow.images
        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(slideshowView: slideshow, slideshowController: ctr)
        ctr.transitioningDelegate = slideshowTransitioningDelegate
        self.present(ctr, animated: true, completion: nil)
        //self.presentViewController(ctr, animated: true, completion: nil)
    }

}

