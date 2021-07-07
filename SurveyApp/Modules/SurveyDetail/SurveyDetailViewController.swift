//
//  SurveyDetailViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

import UIKit
import AlamofireImage

// sourcery: AutoMockable
protocol SurveyDetailViewInput: AnyObject {

    func configure(with survey: Survey)
}

// sourcery: AutoMockable
protocol SurveyDetailViewOutput: AnyObject {

    func viewDidLoad()
    func didPressStartSurvey()
}

final class SurveyDetailViewController: UIViewController {

    var output: SurveyDetailViewOutput?
    
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let gradientLayer = CAGradientLayer()
    private let startButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - SurveyDetailViewInput

extension SurveyDetailViewController: SurveyDetailViewInput {

    func configure(with survey: Survey) {
        setUpLayout()
        setUpViews()
        
        backgroundImageView.af.setImage(withURL: survey.largeImageURL!)
        titleLabel.text = survey.title
        descriptionLabel.text = survey.description
    }
}

// MARK: - Private functions

extension SurveyDetailViewController {
    
    func setUpLayout() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleEdgePan(_:)))
        
        setUpBackButton(tintColor: .white)
        setUpTransparentNavigationBar()
        
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
        view.addGestureRecognizer(panGesture)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).inset(10.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
        }

        startButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalTo(view.snp.bottomMargin).inset(20.0)
            $0.height.equalTo(56.0)
            $0.width.equalTo(140.0)
        }
    }
    
    func setUpViews() {
        backgroundImageView.contentMode = .scaleAspectFill
        
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        
        startButton.setTitle(Localize.startSurveyButtonTitle(), for: .normal)
        startButton.titleLabel?.font = UIFont.bold(ofSize: .heading)
        startButton.tintColor = .black
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 10.0
        startButton.addTarget(self, action: #selector(startSurvey), for: .touchUpInside)

        titleLabel.font = UIFont.bold(ofSize: .largerTitle)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0

        descriptionLabel.font = UIFont.regular(ofSize: .heading)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        descriptionLabel.numberOfLines = 0
    }
}

// MARK: - Actions

extension SurveyDetailViewController {
    
    @objc private func handleEdgePan(_ gesture: UIScreenEdgePanGestureRecognizer) {
        if gesture.state == .began {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func startSurvey() {
        output?.didPressStartSurvey()
    }
}

extension SurveyDetailViewController: ZoomableBackgroundViewController {

    var backgroundView: UIView? { backgroundImageView }
}
