//
//  UserAuthentication.swift
//  MobileAcebook
//
//  Created by Emily Cowan on 12/10/2023.
//

import Foundation

func isValidEmailAddr(strToValidate: String) -> Bool {
  let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
  let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
  return emailValidationPredicate.evaluate(with: strToValidate)
}

func isPasswordValid(password : String) -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}
