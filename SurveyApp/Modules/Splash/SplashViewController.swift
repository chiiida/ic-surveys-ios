//
//  SplashViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import UIKit
import SnapKit

// sourcery: AutoMockable
protocol SplashViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol SplashViewOutput: AnyObject {

    func viewDidLoad()
    func animationDidFinish()
}

final class SplashViewController: UIViewController {

    var output: SplashViewOutput?

    private let backgroundImageView = UIImageView()
    private let logoImageView = UIImageView()
    private let overlayView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - SplashViewInput
extension SplashViewController: SplashViewInput {

    func configure() {
        setUpLayout()
        setUpViews()
        beginAnimation()
    }
}

// MARK: – Private Functions
extension SplashViewController {

    private func setUpLayout() {
        view.addSubview(backgroundImageView)
        view.addSubview(overlayView)
        view.addSubview(logoImageView)

        backgroundImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width)
            $0.height.equalTo(UIScreen.main.bounds.height)
        }

        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(48.0)
            $0.width.equalTo(202.0)
        }
    }

    private func setUpViews() {
        let backgroundImage = R.image.loginBackground()
        let logoImage = R.image.logo()

        navigationController?.isNavigationBarHidden = true

        backgroundImageView.image = backgroundImage

        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlayView.frame = view.bounds

        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.alpha = 0.0
    }

    private func beginAnimation() {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            animations: { [weak self] in
                self?.logoImageView.alpha = 1.0
            },
            completion: { [weak output] _ in
                output?.animationDidFinish()
            }
        )
    }
}
