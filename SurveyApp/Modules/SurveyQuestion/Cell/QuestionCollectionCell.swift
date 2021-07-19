//
//  QuestionCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//

import UIKit
import SnapKit

protocol QuestionCollectionCellDelegate: AnyObject {
    
    func didAnswerForQuestion(with question: QuestionSubmission)
}

protocol QuestionCollectionCellProtocol: AnyObject {
    
    var questionId: String { get set }
    
    var delegate: QuestionCollectionCellDelegate? { get set }
    
    var questionLabel: UILabel { get }
    var answerView: AnswerView { get set }
}

class QuestionCollectionCell: UICollectionViewCell, QuestionCollectionCellProtocol {
    
    var questionId: String = ""
    
    weak var delegate: QuestionCollectionCellDelegate?
    
    var questionLabel: UILabel = UILabel()
    var answerView: AnswerView = DefaultAnswerView()
    
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
    
    func configure(with viewModel: QuestionCollectionCellViewModel) {
        questionLabel.text = viewModel.text
        questionId = viewModel.id
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
        
        answerView.delegate = self
    }
}


// MARK: - AnswerViewDelegate

extension QuestionCollectionCell: AnswerViewDelegate {
    
    func didAnswer(answers: [AnswerSubmission]) {
        let question = QuestionSubmission(id: questionId, answers: answers)
        delegate?.didAnswerForQuestion(with: question)
    }
}
