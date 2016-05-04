# RAkeyboardtoolbar

RAkeyboardToolbar will help you to add accessary toolbar on all UITextFields and UITextViews you want. 



![Alt Text](https://github.com/rhtarora/RAkeyboardtoolbar/blob/master/keyboardToolbar.gif)



Create RAkeyboardAccessoryToolbar class object.

```swift
var keyboardAccessory = RAkeyboardAccessoryToolbar()
```
Add all the textfield in array. 


```swift
keyboardAccessory.textFieldArray = [firstNameTextField, lastnameTextField, emailTextField,phoneTextField]
```

Set textfield as current view in textFieldDidBeginEditing.

```swift
 // MARK: - Textfield Delegates
    func textFieldDidBeginEditing(textField: UITextField!) {
        textField.inputAccessoryView = keyboardAccessory
        keyboardAccessory.currentView = textField
    }
```


