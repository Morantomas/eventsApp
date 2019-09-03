//
//  Helpers.swift
//  Events
//
//  Created by Tomas Moran on 02/09/2019.
//  Copyright © 2019 Tomas Moran. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addToolBarWithClearAndDone() {
        
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clickClear))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(clickDone))
        let SpaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolbar.setItems([clear, SpaceBtn, done], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    func addToolBarWithDone() {
        
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(clickDone))
        let SpaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolbar.setItems([SpaceBtn, done], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func clickClear() {
        self.text = ""
    }
    
    @objc func clickDone() {
        self.endEditing(true)
    }
}

extension UITextView {
    
    func addToolBarWithClearAndDone() {
        
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clickClear))
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(clickDone))
        let SpaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        toolbar.setItems([clear, SpaceBtn, done], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func clickClear() {
        self.text = ""
    }
    
    @objc func clickDone() {
        self.endEditing(true)
    }
}

var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

var dateFormatterToHourMinute: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
