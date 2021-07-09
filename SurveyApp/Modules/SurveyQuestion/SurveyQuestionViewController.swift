//
//  SurveyQuestionViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//
//

import UIKit
import SnapKit
import AlamofireImage

// sourcery: AutoMockable
protocol SurveyQuestionViewInput: AnyObject {

    func configure(with viewModels: [QuestionCollectionCellViewModel])
}

// sourcery: AutoMockable
protocol SurveyQuestionViewOutput: AnyObject {

    func viewDidLoad()
    func didSubmitQuestions(questions: [QuestionSubmission])
}

final class SurveyQuestionViewController: UIViewController {

    var output: SurveyQuestionViewOutput?

    private let backgroundImageView = UIImageView()
    private let gradientLayer = CAGradientLayer()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    private let nextButton = UIButton(type: .system)
    private let submitButton = UIButton(type: .system)
    private let pageNumberLabel = UILabel()
    
    private var questions = QuestionListSection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - SurveyQuestionViewInput

extension SurveyQuestionViewController: SurveyQuestionViewInput {

    func configure(with viewModels: [QuestionCollectionCellViewModel]) {
        self.questions.items = viewModels
        setUpLayout()
        setUpViews()
        collectionView.reloadData()
    }
}

// MARK: - Private Functions

extension SurveyQuestionViewController {
    
    private func setUpLayout() {
        setUpCloseButton(viewController: self, selector: #selector(didTapCloseButton))
        setUpTransparentNavigationBar()
        
        backgroundImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(backgroundImageView)
        view.addSubview(pageNumberLabel)
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(submitButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageNumberLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().inset(112.0)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(54.0)
            $0.height.width.equalTo(56.0)
        }
        
        submitButton.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(54.0)
            $0.height.equalTo(56.0)
            $0.width.equalTo(120.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20.0)
            $0.top.equalTo(pageNumberLabel.snp.bottom).offset(8.0)
            $0.bottom.equalTo(nextButton.snp.top).offset(10.0)
        }
    }
    
    private func setUpViews() {
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.transform = .init(scaleX: 1.5, y: 1.5)
        if let coverImageUrl = questions.sortedQuestions[0].coverImageUrl {
            backgroundImageView.af.setImage(withURL: coverImageUrl)
        }
        
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        
        pageNumberLabel.font = UIFont.bold(ofSize: .body)
        pageNumberLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        
        nextButton.round()
        nextButton.backgroundColor = .clear
        nextButton.setBackgroundImage(Asset.arrowIcon(), for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        submitButton.setTitle(Localize.surveySubmit(), for: .normal)
        submitButton.titleLabel?.font = UIFont.bold(ofSize: .heading)
        submitButton.tintColor = .black
        submitButton.backgroundColor = .white
        submitButton.layer.cornerRadius = 10.0
        submitButton.isHidden = true
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
        
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RatingCollectionCell.self)
        collectionView.register(NPSCollectionCell.self)
        collectionView.register(TextFieldCollectionCell.self)
        collectionView.register(ChoiceCollectionCell.self)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: view.bounds.width - 40.0, height: view.bounds.height - 250.0)
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
        }
    }
    
    private func updateQuestionPaging(pageNumber: Int) {
        pageNumberLabel.text = "\(pageNumber)/\(questions.sortedQuestions.count)"
        
        nextButton.isHidden = pageNumber == questions.sortedQuestions.count ? true : false
        submitButton.isHidden = pageNumber == questions.sortedQuestions.count ? false : true
    }
}

// MARK: - Actions

extension SurveyQuestionViewController {
        
    @objc func didTapCloseButton() {
        showYesCancelAlert(
            title: Localize.alertWraningTitle(),
            message: Localize.alertQuitSurvey(),
            yesHandler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    @objc func didTapNextButton() {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first.flatMap({
                IndexPath(item: $0.item + 1, section: 0)
            }) else { return }

        updateQuestionPaging(pageNumber: indexPath.item + 1)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func didTapSubmitButton() {
        self.navigationController?.popViewController(animated: true)
        output?.didSubmitQuestions(questions: questions.submitedQuestions)
    }
}

// MARK: - UICollectionViewDataSource

extension SurveyQuestionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageNumberLabel.text = "1/\(questions.sortedQuestions.count)"
        return questions.sortedQuestions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = questions.sortedQuestions[indexPath.item].displayType
        let cell: QuestionCollectionCell
        
        switch type {
        case .star, .heart, .smiley:
            cell = collectionView.dequeueReusable(RatingCollectionCell.self, for: indexPath)
        case .nps:
            cell = collectionView.dequeueReusable(NPSCollectionCell.self, for: indexPath)
        case .textarea, .textfield:
            cell = collectionView.dequeueReusable(TextFieldCollectionCell.self, for: indexPath)
        case .choice:
            cell = collectionView.dequeueReusable(ChoiceCollectionCell.self, for: indexPath)
        }
        
        cell.configure(with: questions.sortedQuestions[indexPath.item])
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SurveyQuestionViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        updateQuestionPaging(pageNumber: Int(pageNumber + 1))
    }
}

// MARK: – QuestionCollectionCellDelegate

extension SurveyQuestionViewController: QuestionCollectionCellDelegate {
    
    func didAnswerForQuestion(with question: QuestionSubmission) {
        if let index = questions.submitedQuestions.firstIndex(where: { $0.id == question.id }) {
            questions.submitedQuestions[index].answers = question.answers
        } else {
            questions.submitedQuestions.append(question)
        }
    }
}
