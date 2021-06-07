//
//  LoginViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {

    func configure() {
        setUpViews()
    }
}

extension LoginViewController {
    
    private func setUpViews() {
        view.backgroundColor = .white
    }
}
