//
//  LoginViewController.swift
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

protocol LoginDisplayLogic: class {
    func success()
    func failure (alertController: UIAlertController) -> Void
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    @IBOutlet weak var textFieldUser: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    func setup() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        // router.dataStore = interactor
    }
    
    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
    
    @IBAction func actionLoginUser(_ sender: Any) {
        guard let userValue = textFieldUser.text else { return }
        guard let userPassword = textFieldPassword.text else { return }
        
        interactor?.validateLoginFields(user: userValue, password: userPassword)
    }
    
    func success() {
        
    }
    
    func failure(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Setup Layout
    func setupLayout() {
        buttonLogin.layer.cornerRadius = 4
        buttonLogin.layer.shadowColor = #colorLiteral(red: 0.231372549, green: 0.2823529412, blue: 0.9333333333, alpha: 1)
        buttonLogin.layer.shadowOffset = CGSize(width: 0, height: 3)
        buttonLogin.layer.shadowRadius = 4
        buttonLogin.layer.shadowOpacity = 0.3
    }
}
