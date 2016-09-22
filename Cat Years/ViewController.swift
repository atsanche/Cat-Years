//
//  ViewController.swift
//  Cat Years
//
//  Created by Abel Sanchez on 9/21/16.
//  Copyright © 2016 Abel Sanchez. All rights reserved.
//

import UIKit

extension UIView {
    func pushTransitionUp(duration:CFTimeInterval) {
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
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        print(textInput)
        if (textInput.text?.isEmpty)! {
            textOutput.pushTransitionUp(duration: 1.0)
        } else {
            var answer:Int = Int(textInput.text!)!
            answer = answer * 7
            
            textOutput.pushTransitionUp(duration: 0.6)
            textOutput.text = "\(answer) Years Old"//print(answer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberToolbar.barStyle = UIBarStyle.blackTranslucent
        numberToolbar.items=[
            UIBarButtonItem(title:"Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(ViewController.hoopla)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Apply", style: UIBarButtonItemStyle.bordered, target:self, action: #selector(ViewController.boopla))
        ]
        numberToolbar.sizeToFit()
        textInput.inputAccessoryView = numberToolbar
        
    }
    
    func boopla () {
        textInput.resignFirstResponder()
    }
    
    func hoopla () {
        textInput.text=""
        textInput.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

