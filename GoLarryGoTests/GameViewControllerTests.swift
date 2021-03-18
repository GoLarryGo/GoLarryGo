//
//  HomeViewControllerTests.swift
//  GoLarryGoTests
//
//  Created by Lucas Oliveira on 18/03/21.
//

import XCTest
@testable import GoLarryGo

class GameViewControllerTests: XCTestCase {
    var sut: GameViewController!

    override func setUp() {
        sut = GameViewController()
        sut?.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }

    func test_startGame_pauseScene_false() {

        let viewController = UIViewController()
        sut.startGame(viewController: viewController)

        XCTAssertFalse(sut.scene.isPaused)
    }
    
    func test_startGame_alpha_0() {

        let viewController = UIViewController()
        sut.startGame(viewController: viewController)

        XCTAssert(viewController.view.alpha == 0.0)
    }
}
