//
// AuthenticationService.swift
// MobileAcebook
//
// Created by Josué Estévez Fernández on 01/10/2023.
//

import Foundation


class AuthenticationService: AuthenticationServiceProtocol {
    func signUp(user: User, completion: @escaping (Bool) -> Void) {
    var canSignUp = false
      
    let username = user.username
    let email = user.emailAddress
    let password = user.password
    let confPassword = user.confPassword

    guard let unwrappedUsername = username, let unwrappedEmail = email, let unwrappedPassword = password, let unwrappedConfPassword = confPassword else {
                completion(false)
                return
            }

    let validEmail = isEmailValid(unwrappedEmail)
    let passwordsMatch = doPasswordsMatch(unwrappedPassword, unwrappedConfPassword)
    let validPassword = isPasswordValid(unwrappedPassword)
      
    if validEmail && passwordsMatch && validPassword && unwrappedEmail != "" && unwrappedUsername != "" && unwrappedPassword != "" && unwrappedConfPassword != ""{

      createUser(user: user) {
        result in switch result {
        case .success(let data):
            print("User has been created: \(data)")
          canSignUp = true
            print("ln 34, \(canSignUp)")
            completion(canSignUp)
        case .failure(let error):
          print("Error creating user: \(error)")
          canSignUp = false
            completion(canSignUp)
        }
      }
    } else {
      completion(false) // alert or error message will go here
    }
  }

  func isEmailValid(_ email: String) -> Bool {
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9._%+-]+@[A-Za-z0-9._%+-]+\\.[A-Za-z]{2,}")
    return emailPredicate.evaluate(with: email)
  }

  func doPasswordsMatch(_ password: String, _ confPassword: String) -> Bool {
    if password == confPassword {
      return true
    } else {
      return false
    }
  }

  func isPasswordValid(_ password: String) -> Bool {
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
    return passwordPredicate.evaluate(with: password)
  }

}

