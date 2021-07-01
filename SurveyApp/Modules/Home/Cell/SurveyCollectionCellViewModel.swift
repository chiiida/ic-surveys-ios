//
//  SurveyCollectionCellViewModel.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/30/21.
//

import Foundation

struct SurveyCollectionCellViewModel {
    
    let id: String
    let title: String
    let description: String
    let coverImageUrl: URL?
    
    init(survey: Survey) {
        id = survey.id
        title = survey.title
        description = survey.description
        coverImageUrl = survey.largeImageURL
    }
}
