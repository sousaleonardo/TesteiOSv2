//
//  LoginInteractor.swift
//  BankApp
//
//  Created by Gabriel Henrique Santos Pereira on 12/04/19.
//  Copyright (c) 2019 Gabriel Henrique Santos Pereira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic {
    func validateLoginFields(user: String, password: String) -> Bool
    func loginUser(user: String, password: String) -> Void
}

protocol LoginDataStore {
    var userAccount: LoginResponse.UserAccount? { get }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    var presenter: LoginPresentationLogic?
    var worker = LoginWorker()
    var userAccount: LoginResponse.UserAccount?
    
    // MARK: Business Rules Methods
    
    // This method validates if the values of user and password are not empty
    // He also validates if the user fill a cpf or a email and if the passwords match with the required pattern
    func validateLoginFields(user: String, password: String) -> Bool {
        if valuesAreEmpty(user: user, password: password) && userLoginIsValid(user: user) && passwordIsValid(password: password) {
            self.loginUser(user: user, password: password)
            
            return true
        }
        
        presenter?.showCustomAlert(title: "Usuário não encontrado", message: "Não conseguimos encontrar seu usuário.")
        
        return false
    }
    
    // This method validates if the user value and password value are empty
    func valuesAreEmpty(user: String, password: String) -> Bool {
        if user.isEmpty && password.isEmpty {
            presenter?.showCustomAlert(title: "Dados inválidos", message: "Os campos não podem estar em branco.")
            return false
        }
        
        return true
    }
    
    // This method validates if the user value is a valid email or a valid cpf
    func userLoginIsValid(user: String) -> Bool {
        if user.isValidCPF() || user.isValidEmail() {
            return true
        }
        
        presenter?.showCustomAlert(title: "CPF ou e-mail inválidos", message: "Os dados do seu CPF ou do seu e-mail estão incorretos.")
        
        return false
    }
    
    // This method validates if the password is valid and contains a uppercase character, a number and a special character
    // He also checks if the value is bigger then three characters
    func passwordIsValid(password: String) -> Bool {
        if password.isValidPassword() {
            return true
        }
        
        presenter?.showCustomAlert(title: "Senha inválida", message: "A senha deve conter um caracter maiúsculo, um especial e um número.")
        
        return false
    }
    
    func loginUser(user: String, password: String) {
       let parameters = ["user": user, "password": password]
        
        worker.getUserData(parameters: parameters, responseRequest: { response in
            self.presenter?.login(loginResponse: response)
        })
    }
}
