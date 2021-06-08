//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//
//

import UIKit
import SnapKit

// sourcery: AutoMockable
protocol LoginViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol LoginViewOutput: AnyObject {

    func viewDidLoad()
}

final class LoginViewController: UIViewController {

    var output: LoginViewOutput?
    
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let forgotButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {

    func configure() {
        setUpLayout()
        setUpViews()
    }
}

extension LoginViewController {
    
    private func setUpLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgotButton)
        view.addSubview(loginButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(UIScreen.main.bounds.width)
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40.0)
            $0.width.equalTo(180.0)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(120.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(55.0)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(55.0)
        }
        
        forgotButton.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(20.0)
            $0.trailing.equalTo(passwordField.snp.trailing)
            $0.leading.equalToSuperview().inset(280.0)
            $0.height.equalTo(55.0)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.height.equalTo(55.0)
        }
    }
    
    private func setUpViews() {
        let backgroundImage = R.image.loginBackground()
        let logoImage = R.image.logo()

        navigationController?.isNavigationBarHidden = true
        
        backgroundImageView.image = backgroundImage
        
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        
        emailField.placeholder = "Email"
        emailField.setPlaceholderColor(color: UIColor.white.withAlphaComponent(0.3))
        emailField.layer.cornerRadius = 12.0
        emailField.setPadding(left: 10.0, right: 10.0)
        emailField.textColor = .white
        emailField.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        emailField.keyboardType = .emailAddress
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.font = .regular(ofSize: .body)
        
        passwordField.placeholder = "Password"
        passwordField.setPlaceholderColor(color: UIColor.white.withAlphaComponent(0.3))
        passwordField.layer.cornerRadius = 12.0
        passwordField.setPadding(left: 10.0, right: 10.0)
        passwordField.textColor = .white
        passwordField.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        passwordField.isSecureTextEntry = true
        passwordField.font = .regular(ofSize: .body)
        
        forgotButton.backgroundColor = .clear
        forgotButton.setTitle("Forgot?", for: .normal)
        forgotButton.titleLabel?.font = .regular(ofSize: .body)
        forgotButton.tintColor = UIColor.white.withAlphaComponent(0.3)
        
        loginButton.backgroundColor = .white
        loginButton.setTitle("Log in", for: .normal)
        loginButton.titleLabel?.font = .bold(ofSize: .body)
        loginButton.tintColor = .black
        loginButton.layer.cornerRadius = 10.0
    }
}
