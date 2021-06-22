//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//

import UIKit
import SnapKit

// sourcery: AutoMockable
protocol LoginViewInput: AnyObject, ErrorShowable {

    func configure()
}

// sourcery: AutoMockable
protocol LoginViewOutput: AnyObject {

    func viewDidLoad()
    func didPressLogin(email: String, password: String)
}

final class LoginViewController: UIViewController {

    var output: LoginViewOutput?
    
    private let overlayView = UIView()
    private let blurEffectView = UIVisualEffectView()
    private let gradientLayer = CAGradientLayer()
    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let emailField = CredentialTextField()
    private let passwordField = CredentialTextField()
    private let loginButton = UIButton(type: .system)
    private let forgotButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        beginAnimation()
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
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 202.0, height: 48.0))
        }

        emailField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(302.0)
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
        forgotButton.alpha = 0.0

        loginButton.backgroundColor = .white
        loginButton.setTitle(Localize.loginButtonTitle(), for: .normal)
        loginButton.titleLabel?.font = .bold(ofSize: .body)
        loginButton.tintColor = .black
        loginButton.layer.cornerRadius = 10.0
        loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        loginButton.alpha = 0.0
        
        setUpTextField()
        setUpBlurOverlayView()
    }
    
    private func setUpTextField() {
        emailField.placeholder = Localize.loginEnterEmailPlaceholder()
        emailField.keyboardType = .emailAddress
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.alpha = 0.0

        passwordField.placeholder = Localize.loginEnterPasswordPlaceholder()
        passwordField.textPadding.right = 80.0
        passwordField.isSecureTextEntry = true
        passwordField.alpha = 0.0
    }
    
    private func setUpBlurOverlayView() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView.effect = blurEffect
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.0
        
        overlayView.frame = view.bounds
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        gradientLayer.frame = overlayView.bounds
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.2).cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.75)
        gradientLayer.isHidden = true
    }
    
    func beginAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCurlUp) { [weak self] in
            self?.logoImageView.snp.remakeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(153.0)
                $0.size.equalTo(CGSize(width: 168.0, height: 40.0))
            }
            self?.blurEffectView.alpha = 1.0
            self?.overlayView.backgroundColor = .clear
            self?.gradientLayer.isHidden = false
            self?.emailField.alpha = 1.0
            self?.passwordField.alpha = 1.0
            self?.loginButton.alpha = 1.0
            self?.forgotButton.alpha = 1.0
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: – Actions

extension LoginViewController {

    @objc private func didPressLoginButton() {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        output?.didPressLogin(email: email, password: password)
    }
}
