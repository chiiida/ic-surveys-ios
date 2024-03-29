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
protocol HomeViewInput: AnyObject, ErrorShowable {

    func configure()
    func setUpSurveys(viewModels: [SurveyCollectionCellViewModel])
    func dismissSkeletonView()
}

// sourcery: AutoMockable
protocol HomeViewOutput: AnyObject {

    func viewDidLoad()
    func didPressDetailButton(surveyIndex: Int)
    func didRefreshSurveys(_ completion: EmptyCompletion?)
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
    private let refreshControl = UIRefreshControl()
    private let skeletonView = HomeSkeletonView()
    
    private var surveyListSection = SurveyListSection()

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
        setUpSkeletonView()
        setIdentifiers()
    }
    
    func setUpSurveys(viewModels: [SurveyCollectionCellViewModel]) {
        surveyListSection.items = viewModels
        collectionView.reloadData()
    }
    
    func dismissSkeletonView() {
        UIView.animate(
            withDuration: 0.3,
            animations: { self.skeletonView.alpha = 0.0 },
            completion: { _ in
                self.skeletonView.removeFromSuperview()
            }
        )
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
        collectionView.addSubview(refreshControl)
        
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
        setUpTransparentNavigationBar()
        navigationController?.delegate = self
        
        pageControl.overrideUserInterfaceStyle = .light
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SurveyCollectionCell.self)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.itemSize = UIScreen.main.bounds.size
            layout.minimumLineSpacing = 0.0
            layout.minimumInteritemSpacing = 0.0
        }
        
        surveyDetailButton.round()
        surveyDetailButton.backgroundColor = .clear
        surveyDetailButton.setBackgroundImage(Asset.arrowIcon(), for: .normal)
        surveyDetailButton.addTarget(self, action: #selector(didPressDetailButton), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(handleRefreshControl(_:)), for: .valueChanged)
        refreshControl.tintColor = .white

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
    
    private func setUpSkeletonView() {
        view.addSubview(skeletonView)
        
        skeletonView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        skeletonView.skeletonize()
    }
    
    private func setIdentifiers() {
        view.accessibilityIdentifier = TestConstants.Home.homeView
        surveyDetailButton.accessibilityIdentifier = TestConstants.Home.surveyDetailButton
        collectionView.accessibilityIdentifier = TestConstants.Home.collectionView
    }
}

// MARK: - Actions

extension HomeViewController {
    
    @objc private func didPressDetailButton() {
        output?.didPressDetailButton(surveyIndex: pageControl.currentPage)
    }
    
    @objc private func handleRefreshControl(_ refreshControl: UIRefreshControl) {
        output?.didRefreshSurveys {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = surveyListSection.items.count
        return surveyListSection.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusable(SurveyCollectionCell.self, for: indexPath)
        let viewModel = surveyListSection.items[indexPath.item]
        cell.configure(with: viewModel)
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

extension HomeViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let transition = FadeZoomViewControllerTransition()
        transition.operation = operation
        return transition
    }
}
