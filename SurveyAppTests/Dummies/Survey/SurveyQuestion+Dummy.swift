//
//  SurveyQuestion+Dummy.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 7/13/21.
//

@testable import SurveyApp

extension SurveyQuestion {
    
    static var dummy: SurveyQuestion {
        SurveyQuestion(
            id: "940d229e4cd87cd1e202",
            displayOrder: 0,
            displayType: .star,
            text: "Food â€“ Variety, Taste and Presentation",
            pickType: .one,
            coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l",
            answers: [
                SurveyAnswer(
                    id: "4cbc3e5a1c87d99bc7ee",
                    displayOrder: 0,
                    text: "1",
                    inputPlaceholder: nil,
                    inputMask: nil
                )
            ]
        )
    }
}
