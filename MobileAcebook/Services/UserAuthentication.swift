//
//  UserAuthentication.swift
//  MobileAcebook
//
//  Created by Emily Cowan on 12/10/2023.
//

import Foundation

func isValidEmailAddr(strToValidate: String) -> Bool {
  let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1
    print("I am running")
  let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
    print("I am also running")
  return emailValidationPredicate.evaluate(with: strToValidate)  // 3
}

func isPasswordValid(password : String) -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}


//const validatePassword = (password) => {
//  const errors = [];
//  if (password.length < 10) {
//    errors.push('Minimum 10 characters; ');
//  }
//  if (!/[A-Z]/.test(password)) {
//    errors.push('1 uppercase letter; ');
//  }
//  if (!/[!@#$%^&*]/.test(password)) {
//    errors.push('1 special character; ');
//  }
//  if (!/\d/.test(password)) {
//    errors.push('1 number; ');
//  }
//  return errors;
//};
