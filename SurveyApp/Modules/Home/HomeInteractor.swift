//
//  HomeInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/10/21.
//  
//

// sourcery: AutoMockable
protocol HomeInteractorInput: AnyObject {
}

// sourcery: AutoMockable
protocol HomeInteractorOutput: AnyObject {
}

final class HomeInteractor {

    weak var output: HomeInteractorOutput?
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
}
