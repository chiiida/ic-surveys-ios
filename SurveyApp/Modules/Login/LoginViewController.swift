//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
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
    
    private let overlayView = UIView()
    private let blurEffectView = UIVisualEffectView()
    private let gradientLayer = CAGradientLayer()
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let emailField = TextFieldWithPadding()
    private let passwordField = TextFieldWithPadding()
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

// MARK: - Private functions

extension LoginViewController {

    private func setUpLayout() {
        overlayView.layer.insertSublayer(gradientLayer, at: 0)

        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(overlayView)
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgotButton)
        view.addSubview(loginButton)

        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
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
        let backgroundImage = Asset.loginBackground()
        let logoImage = Asset.logo()

        navigationController?.isNavigationBarHidden = true

        backgroundImageView.image = backgroundImage

        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit

        forgotButton.backgroundColor = .clear
        forgotButton.setTitle(Localize.loginForgetButtonTitle(), for: .normal)
        forgotButton.titleLabel?.font = .regular(ofSize: .body)
        forgotButton.tintColor = UIColor.white.withAlphaComponent(0.3)

        loginButton.backgroundColor = .white
        loginButton.setTitle(Localize.loginButtonTitle(), for: .normal)
        loginButton.titleLabel?.font = .bold(ofSize: .body)
        loginButton.tintColor = .black
        loginButton.layer.cornerRadius = 10.0
        
        setUpTextField()
        setUpBlurOverlayView()
    }
    
    private func setUpTextField() {
        emailField.placeholder = Localize.loginEnterEmailPlaceholder()
        emailField.placeholderColor = UIColor.white.withAlphaComponent(0.3)
        emailField.layer.cornerRadius = 12.0
        emailField.textColor = .white
        emailField.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        emailField.keyboardType = .emailAddress
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.font = .regular(ofSize: .body)

        passwordField.placeholder = Localize.loginEnterPasswordPlaceholder()
        passwordField.placeholderColor = UIColor.white.withAlphaComponent(0.3)
        passwordField.textPadding.right = 80.0
        passwordField.layer.cornerRadius = 12.0
        passwordField.textColor = .white
        passwordField.backgroundColor = UIColor.white.withAlphaComponent(0.18)
        passwordField.isSecureTextEntry = true
        passwordField.font = .regular(ofSize: .body)
    }
    
    private func setUpBlurOverlayView() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        overlayView.frame = view.bounds
        
        gradientLayer.frame = overlayView.bounds
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.2).cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.75)
    }
}
