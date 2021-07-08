//
//  QuestionCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//

import UIKit
import SnapKit

protocol QuestionCollectionCellProtocol {
    
    var questionLabel: UILabel { get }
    var answerView: UIView { get set }
}

class QuestionCollectionCell: UICollectionViewCell, QuestionCollectionCellProtocol {
    
    var questionLabel: UILabel = UILabel()
    var answerView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func draw(_ rect: CGRect) {
        setUpLayout()
        setUpViews()
        super.draw(rect)
    }
    
    func configure(with question: SurveyQuestion) {
        questionLabel.text = question.text
    }
    
    private func setUpLayout() {
        contentView.addSubview(questionLabel)
        contentView.addSubview(answerView)
        
        questionLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
        
        answerView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        questionLabel.font = UIFont.bold(ofSize: .largerTitle)
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 4
    }
}
