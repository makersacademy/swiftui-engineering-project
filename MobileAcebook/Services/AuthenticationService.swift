//
// AuthenticationService.swift
// MobileAcebook
//
// Created by Josué Estévez Fernández on 01/10/2023.
//
import Foundation

class AuthenticationService: AuthenticationServiceProtocol {
  func signUp(user: User) -> Bool {
    var canSignUp = false
    let email = user.email
    let password = user.password
    let confPassword = user.confPassword

    guard let unwrappedEmail = email else { return false }
    guard let unwrappedPassword = password else { return false }
    guard let unwrappedConfPassword = confPassword else { return false }

    let validEmail = isEmailValid(unwrappedEmail)
    let passwordsMatch = doPasswordsMatch(unwrappedPassword, unwrappedConfPassword)
    let validPassword = isPasswordValid(unwrappedPassword)

    if validEmail && passwordsMatch && validPassword {

      createUser3(user: user) {
        result in switch result {
        case .success(let data):
          print("User has been created: \(data)")
          canSignUp = true
        case .failure(let error):
          print("Error creating user: \(error)")
          canSignUp = false
        }
      }

      return canSignUp
    } else {
      return canSignUp // alert or error message will go here
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
