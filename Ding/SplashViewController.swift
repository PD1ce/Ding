//
//  SplashViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/18/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class SplashViewController : UIViewController {
    
    var dLetter: LetterView!
    var iLetter: LetterView!
    var nLetter: LetterView!
    var gLetter: LetterView!
    var eLetter: LetterView!
    
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let blackColor = UIColor(white: 0.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.2, alpha: 1.0)
        let viewHeight = view.frame.height
        dLetter = LetterView(frame: CGRect(x: 151, y: 69, width: 72, height: 72), letter: "D")
        iLetter = LetterView(frame: CGRect(x: 151, y: 149, width: 72, height: 72), letter: "I")
        nLetter = LetterView(frame: CGRect(x: 151, y: 229, width: 72, height: 72), letter: "N")
        gLetter = LetterView(frame: CGRect(x: 151, y: 309, width: 72, height: 72), letter: "G")
        eLetter = LetterView(frame: CGRect(x: 151, y: 389, width: 72, height: 72), letter: "!")
        view.addSubview(dLetter)
        view.addSubview(iLetter)
        view.addSubview(nLetter)
        view.addSubview(gLetter)
        view.addSubview(eLetter)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // D LETTER
        
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.dLetter.frame = CGRect(x: self.view.frame.width / 2 - 180, y: 40, width: 72, height: 72)
        }, completion: {
            (value: Bool) in
        })
        
        // I LETTER
        UIView.animateWithDuration(0.5, delay: 0.4, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.iLetter.frame = CGRect(x: self.view.frame.width / 2 - 108, y: 40, width: 72, height: 72)
        }, completion: {
            (value: Bool) in
        })
        // N LETTER
        UIView.animateWithDuration(0.5, delay: 0.6, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.nLetter.frame = CGRect(x: self.view.frame.width / 2 - 36, y: 40, width: 72, height: 72)
        }, completion: {
            (value: Bool) in
        })
        // G LETTER
        UIView.animateWithDuration(0.5, delay: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.gLetter.frame = CGRect(x: self.view.frame.width / 2 + 36, y: 40, width: 72, height: 72)
        }, completion: {
            (value: Bool) in
        })
        // ! LETTER
        UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.eLetter.frame = CGRect(x: self.view.frame.width / 2 + 108, y: 40, width: 72, height: 72)
        }, completion: {
            (value: Bool) in
            // Do after with delay
            UIView.animateWithDuration(2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.view.backgroundColor = UIColor(white: 0.86, alpha: 1.0)
                self.dLetter.frame = CGRect(x: self.view.frame.width / 2 - 108, y: 40, width: 72, height: 72)
                self.iLetter.frame = CGRect(x: self.view.frame.width / 2 - 72, y: 40, width: 72, height: 72)
                self.gLetter.frame = CGRect(x: self.view.frame.width / 2 + 24, y: 40, width: 72, height: 72)
                self.eLetter.frame = CGRect(x: self.view.frame.width / 2 + 64, y: 40, width: 72, height: 72)
                }, completion: {
                    (value: Bool) in
                    UIView.animateWithDuration(1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                        self.view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
                        }, completion: {
                            (value: Bool) in
                            self.modalPresentationStyle = UIModalPresentationStyle.None
                            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
                            loginVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                            self.presentViewController(loginVC, animated: true, completion: nil)
                    })
                    
            })
            
        })
    }
    
    class LetterView : UILabel {
        
        init(frame: CGRect, letter: String) {
            super.init(frame: frame)
            font = UIFont(name: "Helvetica", size: 84)
            textColor = UIColor(white: 0.0, alpha: 1.0)
            text = letter
            //backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            textAlignment = NSTextAlignment(rawValue: 1)!
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
}
