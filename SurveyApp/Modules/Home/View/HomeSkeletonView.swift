//
//  HomeSkeletonView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/13/21.
//

import UIKit
import SkeletonView

final class HomeSkeletonView: UIView {
    
    private let dateLabel = UILabel()
    private let todayLabel = UILabel()
    private let profileButton = UIButton()
    private let pageControl = UILabel()
    private let surveyTitle = UILabel()
    private let surveyDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
        setUpView()
    }
    
    private func setUpLayout() {
        addSubview(dateLabel)
        addSubview(todayLabel)
        addSubview(profileButton)
        addSubview(pageControl)
        addSubview(surveyTitle)
        addSubview(surveyDescription)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(70.0)
            $0.width.equalTo(120.0)
        }
        
        todayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalTo(dateLabel.snp.bottom).offset(30.0)
            $0.width.equalTo(100.0)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(80.0)
            $0.height.width.equalTo(36.0)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20.0)
            $0.bottom.equalToSuperview().offset(-200.0)
            $0.width.equalTo(30.0)
        }
        
        surveyTitle.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(30.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(102.0)
        }

        surveyDescription.snp.makeConstraints {
            $0.top.equalTo(surveyTitle.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }
    
    private func setUpView() {
        SkeletonAppearance.default.multilineSpacing = 5.0
        SkeletonAppearance.default.multilineCornerRadius = 8
        
        isSkeletonable = true
        backgroundColor = .black
        
        dateLabel.numberOfLines = 1
        dateLabel.isSkeletonable = true
        
        todayLabel.numberOfLines = 1
        todayLabel.isSkeletonable = true
        
        profileButton.layer.cornerRadius = 18.0
        profileButton.layer.masksToBounds = true
        profileButton.isSkeletonable = true
        
        pageControl.numberOfLines = 1
        pageControl.isSkeletonable = true
        
        surveyTitle.numberOfLines = 2
        surveyTitle.isSkeletonable = true
        surveyTitle.lastLineFillPercent = 50
        
        surveyDescription.numberOfLines = 2
        surveyDescription.isSkeletonable = true
    }
}
