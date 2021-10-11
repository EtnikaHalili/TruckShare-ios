//
//  Extensions.swift
//  OrderApp
//
//  Created by Majlinda - INNO on 25.6.21.
//

import Foundation
import UIKit

extension UIView{
    //borders
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }
    //Shadow
    func showShadow(){
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}

extension UIViewController {
  func showAlertWith(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive, handler: nil))
    self.present(alert, animated: true)
  }
}
