//
//  ViewController.swift
//  RAkeyboardToolbar
//
//  Copyright © 2016 Rohit Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var keyboardAccessory = RAkeyboardAccessoryToolbar()
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    var textFieldArray:[UITextField] = []
    override func viewDidLoad() {
         textFieldArray = [firstNameTextField, lastnameTextField, emailTextField,phoneTextField]
        keyboardAccessory.textFieldArray = textFieldArray
        keyboardAccessory.textViewArray = [detailTextView]
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // MARK: - Textfield Delegates
    func textFieldDidBeginEditing(textField: UITextField!) {
        textField.inputAccessoryView = keyboardAccessory
        keyboardAccessory.currentView = textField
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        for i in 0 ..< textFieldArray.count {
            if i == textFieldArray.count-1 {
                textField.resignFirstResponder()
                break
            } else {
                if textField == textFieldArray[i] {
                    textFieldArray[i+1].becomeFirstResponder()
                    break
                }
            }
        }
        return true
    }
    
    // MARK: - TextView Delegates
    func textViewDidBeginEditing(textView: UITextView!) {
        textView.inputAccessoryView = keyboardAccessory
        keyboardAccessory.currentView = textView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

