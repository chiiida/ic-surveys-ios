//
//  SplashPresenterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/24/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SplashPresenterSpec: QuickSpec {

    override func spec() {

        var presenter: SplashPresenter!
        var router: SplashRouterInputMock!
        var interactor: SplashInteractorInputMock!
        var view: SplashViewInputMock!
        var output: SplashOutputMock!

        describe("a SplashPresenter") {
            beforeEach {
                router = SplashRouterInputMock()
                interactor = SplashInteractorInputMock()
                view = SplashViewInputMock()
                presenter = SplashPresenter(
                    router: router,
                    interactor: interactor
                )
                output = SplashOutputMock()
                presenter.output = output
                presenter.view = view
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    presenter.viewDidLoad()
                }

                it("triggers view to configure view") {
                    expect(view.configureCalled) == true
                }
            }
            
            describe("its animationDidFinish is called") {
                context("when the user is authenticated") {
                    beforeEach {
                        interactor.isLoggedIn = true
                        presenter.animationDidFinish()
                    }

                    it("triggers router to call showHome") {
                        expect(router.showHomeCalled) == true
                    }
                }
                
                context("when the user is unauthenticated") {
                    beforeEach {
                        interactor.isLoggedIn = false
                        presenter.animationDidFinish()
                    }

                    it("triggers router to call showLogin") {
                        expect(router.showLoginCalled) == true
                    }
                }
            }
        }
    }
}
