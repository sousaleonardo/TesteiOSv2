//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic {
    func showCustomAlert(title: String, message: String) -> Void
    func login(loginResponse: LoginResponse) -> Void
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?
    
    // Method to create a custom alert message inside ViewController
    func showCustomAlert(title: String, message: String) {
        let customAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            customAlert.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler: nil))
        
        viewController?.failure(alertController: customAlert)
    }
    
    func login(loginResponse: LoginResponse) {
        viewController?.success(userData: loginResponse)
    }
}
