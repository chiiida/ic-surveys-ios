//
//  SurveyQuestionViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

import UIKit
import SnapKit

// sourcery: AutoMockable
protocol SurveyQuestionViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol SurveyQuestionViewOutput: AnyObject {

    func viewDidLoad()
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
    
    private let questions = [
        SurveyQuestion(
            id: "1",
            displayOrder: 1,
            displayType: .heart,
            text: "Food â€“ Variety, Taste and Presentation",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 3, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 4, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 5, text: "1", inputPlaceholder: nil, inputMask: nil)
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 2,
            displayType: .star,
            text: "Quality of Service, Speed and Efficiency",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 3, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 4, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 5, text: "1", inputPlaceholder: nil, inputMask: nil)
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 3,
            displayType: .smiley,
            text: "Staff- Friendliness and Helpfulness",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 3, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 4, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 5, text: "1", inputPlaceholder: nil, inputMask: nil)
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 3,
            displayType: .nps,
            text: "How likely is that you would recommend. Scarlett to a friend or colleague?",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "1", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "1", inputPlaceholder: nil, inputMask: nil)
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 6,
            displayType: .choice,
            text: "How did you hear about us?",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "TripAdvisor", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "Newspaper/Magazine Story", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 3, text: "Website", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 4, text: "Social Media", inputPlaceholder: nil, inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 5, text: "Staying at hotel", inputPlaceholder: nil, inputMask: nil),
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 4,
            displayType: .textfield,
            text: "Don't miss out on our Exclusive Promotions!",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "First Name", inputPlaceholder: "John", inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 2, text: "1", inputPlaceholder: "Email", inputMask: nil),
                SurveyAnswer(id: "a1", displayOrder: 3, text: "1", inputPlaceholder: "Mobile Number", inputMask: nil)
            ]
        ),
        SurveyQuestion(
            id: "1",
            displayOrder: 5,
            displayType: .textarea,
            text: "Your additional comments are welcomed.",
            pickType: "one",
            answers: [
                SurveyAnswer(id: "a1", displayOrder: 1, text: "First Name", inputPlaceholder: "John", inputMask: nil),
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - SurveyQuestionViewInput

extension SurveyQuestionViewController: SurveyQuestionViewInput {

    func configure() {
        setUpLayout()
        setUpViews()
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
        backgroundImageView.image = Asset.sampleBackground3()
        backgroundImageView.transform = .init(scaleX: 1.5, y: 1.5)
        
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        
        pageNumberLabel.font = UIFont.bold(ofSize: .body)
        pageNumberLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(QuestionCollectionCell.self)
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
    }
    
    private func updateQuestionPaging(pageNumber: Int) {
        pageNumberLabel.text = "\(pageNumber)/\(questions.count)"
        
        if pageNumber == questions.count {
            nextButton.isHidden = true
            submitButton.isHidden = false
        } else {
            nextButton.isHidden = false
            submitButton.isHidden = true
        }
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
}

// MARK: - UICollectionViewDataSource

extension SurveyQuestionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageNumberLabel.text = "1/\(questions.count)"
        return questions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(QuestionCollectionCell.self, for: indexPath)
        cell.configure(with: questions[indexPath.item])
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
