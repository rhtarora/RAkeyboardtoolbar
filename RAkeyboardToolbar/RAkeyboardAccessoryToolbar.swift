//
//  RAkeyboardAccessoryToolbar.swift
//
//  Copyright (c) 2016 Rohit Arora. All rights reserved.
//

import UIKit

class RAkeyboardAccessoryToolbar: UIToolbar {
  private static let toolBarHeight: CGFloat = 44
  var textFieldArray = [UITextField]()
  var textViewArray = [UITextView]()
  var prevButton = UIBarButtonItem()
  var nextButton = UIBarButtonItem()
  var index = Int()
  // MARK: - Initialization
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: RAkeyboardAccessoryToolbar.toolBarHeight))
    addBarItems()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addBarItems()
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  // MARK: - Custom bar items
  func addBarItems() {
    prevButton = UIBarButtonItem(image: UIImage(named: "keyboardPreviousButton"), style: UIBarButtonItemStyle.Plain, target: self, action:#selector(RAkeyboardAccessoryToolbar.previousTextField) )
    nextButton = UIBarButtonItem(image: UIImage(named: "keyboardNextButton"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(RAkeyboardAccessoryToolbar.nextTextField))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
    let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(RAkeyboardAccessoryToolbar.done))
    if let textField = currentView as? UITextField {
      if textField == textFieldArray.first {
        prevButton.enabled = false
      }
      if textField == textFieldArray.last {
        nextButton.enabled = false
      }
    }
    
    if let textView = currentView as? UITextView {
      if textView == textViewArray.first {
        prevButton.enabled = false
      }
      if textView == textViewArray.last {
        nextButton.enabled = false
      }
    }
    
    if textFieldArray.count > 1 || textViewArray.count > 1 {
      items = [prevButton, nextButton,flexibleSpace, doneBarButton]
    } else {
      items = [flexibleSpace, doneBarButton]
    }
  }
  
  func done() {
    var shouldReturn = true
    if let textField = currentView as? UITextField {
      shouldReturn = textField.delegate?.textFieldShouldEndEditing?(textField) ?? shouldReturn
    } else if let textView = currentView as? UITextView {
      shouldReturn = textView.delegate?.textViewShouldEndEditing?(textView) ?? shouldReturn
    }
    
    if shouldReturn {
      print("shouldReturn")
      currentView?.resignFirstResponder()
    }
  }
  
  func previousTextField() {
    if let textField = currentView as? UITextField {
      if textField != textFieldArray.first {
        textFieldArray[index - 1].becomeFirstResponder()
      }
    }
    if let textField = currentView as? UITextView {
        if textField != textFieldArray.first {
            textFieldArray[index - 1].becomeFirstResponder()
        }
    }
  }
  
  func nextTextField() {
    if let textField = currentView as? UITextField {
      if textField != textFieldArray.last {
        textFieldArray[index + 1].becomeFirstResponder()
      }
    }
  }
  
  // MARK: - Current view relation
  weak var currentView: UIView? {
    didSet {
      addBarItems()
      if let textField = currentView as? UITextField {
        textField.inputAccessoryView = self
        index = (textFieldArray as NSArray).indexOfObject(textField)
        
        if textField == textFieldArray.first {
          prevButton.enabled = false
        } else {
          prevButton.enabled = true
        }
        
        if textField == textFieldArray.last {
          nextButton.enabled = false
        } else {
          nextButton.enabled = true
        }
        
      } else if let textView = currentView as? UITextView {
        textView.inputAccessoryView = self
        index = (textViewArray as NSArray).indexOfObject(textView)
        
        if textView == textViewArray.first {
          prevButton.enabled = false
        } else {
          prevButton.enabled = true
        }
        
        if textView == textViewArray.last {
          nextButton.enabled = false
        } else {
          nextButton.enabled = true
        }
      }
    }
  }
}
