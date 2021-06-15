//
//  ErrorView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//

import UIKit

final class ErrorView: UIView {

    private let errorTitleLabel = UILabel()
    private let errorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setErrorMessage(_ message: String) {
        errorLabel.text = message
    }
    
    func show(on controller: UIView) {
        snp.makeConstraints {
            $0.top.equalTo(controller.snp.top).offset(50.0)
            $0.leading.equalTo(controller.snp.leading).inset(24.0)
            $0.trailing.equalTo(controller.snp.trailing).inset(24.0)
        }
        perfromAnimation()
    }

    private func setUpLayout() {
        addSubview(errorTitleLabel)
        addSubview(errorLabel)

        errorTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(10.0)
            $0.centerX.equalToSuperview()
        }

        errorLabel.snp.makeConstraints {
            $0.top.equalTo(errorTitleLabel.snp.bottom).offset(5.0)
            $0.bottom.equalToSuperview().inset(10.0)
            $0.leading.equalTo(errorTitleLabel.snp.leading)
            $0.centerX.equalToSuperview()
        }
    }

    private func setUpViews() {
        backgroundColor = UIColor.white.withAlphaComponent(0.8)
        layer.cornerRadius = 10.0

        errorTitleLabel.text = Localize.errorBannerTitle()
        errorTitleLabel.font = .bold(ofSize: .body)
        errorTitleLabel.textColor = .black

        errorLabel.font = .regular(ofSize: .small)
        errorLabel.textColor = .black
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
    }
}

// MARK: - Actions

extension ErrorView {

    private func perfromAnimation() {
        self.alpha = 1.0

        UIView.animate(withDuration: 1.0, delay: 1.0) {
            self.alpha = 0.0
        }
    }
}
