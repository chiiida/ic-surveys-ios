//
//  HomeViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

import UIKit
import SnapKit

// sourcery: AutoMockable
protocol HomeViewInput: AnyObject {

    func configure()
}

// sourcery: AutoMockable
protocol HomeViewOutput: AnyObject {

    func viewDidLoad()
}

final class HomeViewController: UIViewController {

    var output: HomeViewOutput?
    
    private let dateLabel = UILabel()
    private let todayLabel = UILabel()
    private let userProfileButton = UIButton(type: .system)
    private let surveyDetailButton = UIButton(type: .system)
    private let pageControl = UIPageControl()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: AnimatedCollectionViewLayout(animationStyle: .fade)
    )
    
    // TODO: replace hard code use case with list of Survey objects from API
    private let backgrounds = [Asset.sampleBackground3(), Asset.sampleBackground2(), Asset.sampleBackground1()]
    private let titles = ["Working from home Check-In", "Career training and development", "Inclusion and belonging"]
    private let descriptions = [
        "We would like to know how you feel about our work from home...",
        "We would like to know what are your goals and skills you wanted...",
        "Building a workplace culture that prioritizes belonging and inclusio..."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {

    func configure() {
        setUpLayout()
        setUpViews()
    }
}

// MARK: - Private Functions

extension HomeViewController {
    
    private func setUpLayout() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(dateLabel)
        view.addSubview(todayLabel)
        view.addSubview(userProfileButton)
        view.addSubview(surveyDetailButton)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().inset(195.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(60.0)
        }
        
        todayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.0)
            $0.top.equalTo(dateLabel.snp.bottom)
        }
        
        userProfileButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview().offset(80.0)
            $0.height.width.equalTo(36.0)
        }
        
        surveyDetailButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview().inset(54.0)
            $0.height.width.equalTo(56.0)
        }
    }
    
    private func setUpViews() {
        navigationController?.isNavigationBarHidden = true
        
        pageControl.overrideUserInterfaceStyle = .light
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SurveyCollectionCell.self)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = UIScreen.main.bounds.size
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
        }
        
        surveyDetailButton.round()
        surveyDetailButton.backgroundColor = .clear
        surveyDetailButton.setBackgroundImage(Asset.arrowIcon(), for: .normal)

        setUpHeaderView()
    }
    
    private func setUpHeaderView() {
        dateLabel.text = Date().formatted(with: .dateFormatter).uppercased()
        dateLabel.textColor = .white
        dateLabel.font = UIFont.bold(ofSize: .small)
        
        todayLabel.text = Localize.homeTodayLabel()
        todayLabel.textColor = .white
        todayLabel.font = UIFont.bold(ofSize: .largerTitle)
        
        userProfileButton.round()
        userProfileButton.backgroundColor = .clear
        userProfileButton.setBackgroundImage(Asset.userAvatar(), for: .normal)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: update to count surveys list instead
        pageControl.numberOfPages = backgrounds.count
        return backgrounds.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(SurveyCollectionCell.self, for: indexPath)
        // TODO: remove hard code use case when integrate
        guard let background = backgrounds[indexPath.item] else { return cell }
        let title = titles[indexPath.item]
        let description = descriptions[indexPath.item]
        // TODO: replace empty string with survey cover image url
        cell.configure(title: title, description: description, imageURLString: "")
        cell.setImage(image: background)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
