//
//  UserLoginViewController.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

protocol UserLoginDisplayLogic: class {
    func displaySomething(viewModel: UserLogin.CheckFields.ViewModel)
}

final class UserLoginViewController: UIViewController, UserLoginDisplayLogic {
    var interactor: UserLoginBusinessLogic?
    var router: (NSObjectProtocol & UserLoginRoutingLogic & UserLoginDataPassing)?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        UserLoginConfigurator.shared.configurate(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        UserLoginConfigurator.shared.configurate(self)
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
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self
        check()
    }
    
    
    // MARK: - IBAction functions
    
    @IBAction private func tapLoginButton(_ sender: Any) {
        check()
    }
    
    
    @IBAction private func editingChangeNameTextField(_ sender: Any) {
        check()
    }
    
    @IBAction private func editingChangeMailTextField(_ sender: Any) {
        check()
    }
    
    
    @IBAction private func editingChangePasswordTextField(_ sender: Any) {
        check()
    }
    
    
    private func check() {
        let request = UserLogin.CheckFields.Request(userName: nameTextField.text,
                                                    userMail: mailTextField.text,
                                                    userPassword: passwordTextField.text)
        interactor?.textFieldsCheck(request: request)
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    
    func displaySomething(viewModel: UserLogin.CheckFields.ViewModel) {
        //nameTextField.text = viewModel.name
        if viewModel.status {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
}
