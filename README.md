## How it work

A custom SwiftUI `TextField` to show floating labels and allow flexible validation for user input.

https://github.com/user-attachments/assets/bb30ea3d-fce3-423f-b5bf-c27a87d9e99d

## Add to your project by using SPM
Use SPM to add the custom SwiftUI `TextField` to your project

### The example code for the email input field

```
// On top of your UI file 
import FloatingInputField

TextInputField(
 "Email address",
 text: $email,
 isValid: $isEmailValid)
  .isMandatory(true)
  .onValidate { value in
    value.isValidEmail ? .success(true) : .failure(.invalidEmail)
   }
  .autocapitalization(.none)
```

