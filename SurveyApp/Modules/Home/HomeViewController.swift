//
//  HomeViewController.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/10/21.
//  
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
}

// MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {

    func configure() {
        setUpViews()
    }
}

// MARK: – Private Functions

extension HomeViewController {
    
    private func setUpViews() {
        navigationItem.title = "Home Screen"
        view.backgroundColor = .white
    }
}
