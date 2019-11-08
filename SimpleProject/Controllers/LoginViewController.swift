//
//  LoginViewController.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/7/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var loginStackViewBottomConstraint: NSLayoutConstraint!
    
    private var originalloginStackViewBottomConstraint: CGFloat = 0.0
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupTextFields()
        keyboardAddObserver()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextField.becomeFirstResponder()
        userNameTextField.text = ""
        userPasswordTextField.text = ""
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        var isLogin = true
        if userNameTextField.text!.isEmpty {
            userNameTextField.layer.borderColor = ORANGE_THEME.cgColor
            isLogin = false
            showTextFieldMissingInformationAlert()
        }
        
        if userPasswordTextField.text!.isEmpty {
            userPasswordTextField.layer.borderColor = ORANGE_THEME.cgColor
            isLogin = false
            showTextFieldMissingInformationAlert()
        }
        
        if isLogin && userNameTextField.text == ProfileViewController.user.name && userPasswordTextField.text == ProfileViewController.user.password {
            let vc = ProfileViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showWrongUserNameOrPasswordAlert()
        }
    }
    
    private func setupTextFields() {
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
        
        userNameTextField.layer.borderWidth = 2
        userNameTextField.layer.borderColor = UIColor.white.cgColor
        
        userPasswordTextField.layer.borderWidth = 2
        userPasswordTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: - Alert Methods
    private func showWrongUserNameOrPasswordAlert() {
        let alert = UIAlertController(title: "Wrong UserName or Password", message: "Try Again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showTextFieldMissingInformationAlert() {
        let alertController = UIAlertController(title: "Missing Information", message: "You left one or more fields empty. Please make sure that all fields are filled before attempting to save.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Notification Center Methods
    private func keyboardAddObserver() {
        originalloginStackViewBottomConstraint = loginStackViewBottomConstraint.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            loginStackViewBottomConstraint.constant = keyboardSize.cgRectValue.height + 20
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        loginStackViewBottomConstraint.constant = originalloginStackViewBottomConstraint
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let isEqual = textField == userNameTextField
        if isEqual {
            userNameTextField.layer.borderColor = UIColor.white.cgColor
        } else {
            userPasswordTextField.layer.borderColor = UIColor.white.cgColor
        }
    }
}
