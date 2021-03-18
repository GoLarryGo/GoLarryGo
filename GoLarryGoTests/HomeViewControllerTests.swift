//
//  HomeViewControllerTests.swift
//  GoLarryGoTests
//
//  Created by Lucas Oliveira on 18/03/21.
//

import XCTest
@testable import GoLarryGo

class HomeViewControllerTests: XCTestCase {
    var sut: HomeViewController?

    override func setUp() {
        sut = HomeViewController()
        sut?.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }

    
}
