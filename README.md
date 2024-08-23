## How it work

https://github.com/user-attachments/assets/bb30ea3d-fce3-423f-b5bf-c27a87d9e99d

## Add to your project by using SPM

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

