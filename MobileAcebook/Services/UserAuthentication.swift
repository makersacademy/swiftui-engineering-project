//
//  UserAuthentication.swift
//  MobileAcebook
//
//  Created by Emily Cowan on 12/10/2023.
//

import Foundation

//func validateEmail(email: String) -> [String] {
//    var errors: [String] = []
//    var emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i
//    if let !emailRegex
//}
//
//
//
//
//const validateEmail = (email) => {
//  const errors = [];
//  const emailRegex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/i;
//  if (!emailRegex.test(email)) {
//    errors.push('Please enter a valid email address. Ex: example@email.com');
//  }
//  if (email.trim() === '') {
//    errors.length = 0;
//  }
//  return errors;
//};


func isValidEmailAddr(strToValidate: String) -> Bool {
  let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1
    print("I am running")
  let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2
    print("I am also running")
  return emailValidationPredicate.evaluate(with: strToValidate)  // 3
}
