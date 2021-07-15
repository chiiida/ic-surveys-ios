//
//  CompleteSurveyView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/11/21.
//

import UIKit
import SnapKit
import Lottie

class CompleteSurveyView: UIView {
    
    private let textLabel = UILabel()
    private let lottieView = LottieAnimationViews.completeSurveyView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(lottieView)
        addSubview(textLabel)
        
        lottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(200.0)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(lottieView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
    }
    
    private func setUpView() {
        backgroundColor = .black
        
        textLabel.text = Localize.lottieCompleteSurvey()
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = .bold(ofSize: .largerTitle)
        textLabel.numberOfLines = 0
    }
}

extension CompleteSurveyView {
    
    func show(completion: EmptyCompletion? = nil) {
        presentViewOnTopWindow(for: 0.8) {
            completion?()
        }
    }
}
