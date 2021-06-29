//
//  SurveyDetailViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol SurveyDetailViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol SurveyDetailViewOutput: AnyObject {

    func viewDidLoad()
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

    func configure() {
        setUpLayout()
        setUpViews()
    }
}

// MARK: - Private functions

extension SurveyDetailViewController {
    
    func setUpLayout() {
        navigationController?.isNavigationBarHidden = false
        
        setUpBackButton(tintColor: .white)
        setTransparentNavigationBar()
        
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
        
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
        // TODO: replace with cover image from API
        backgroundImageView.image = Asset.sampleBackground3()
        backgroundImageView.transform = .init(scaleX: 1.3, y: 1.3)
        
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        
        startButton.setTitle(Localize.startSurveyButtonTitle(), for: .normal)
        startButton.titleLabel?.font = UIFont.bold(ofSize: .heading)
        startButton.tintColor = .black
        startButton.backgroundColor = .white
        startButton.layer.cornerRadius = 10.0

        titleLabel.font = UIFont.bold(ofSize: .largerTitle)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        // TODO: remove hard code
        titleLabel.text = "Working from home Check-In"

        descriptionLabel.font = UIFont.regular(ofSize: .heading)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        descriptionLabel.numberOfLines = 0
        // TODO: remove hard code
        descriptionLabel.text = "We would like to know how you feel about our work from home (WFH) experience."
    }
}
