//
//  HomeViewControllerTests.swift
//  InstagramTests
//
//  Created by Denys Melnykov on 19.02.2021.
//

import XCTest
import UIKit
@testable import Instagram

class HomeViewControllerTests: XCTestCase {
    
    var sut: HomeViewController!
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_view_is_loaded() {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.view, "view isn't load")
    }
    
    func test_view_will_appered() {
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func test_posts_did_fetch_fail() {
        let error = "Foo"
        sut.postsDidFetchFail(with: error)
        AlertService.shared.showErrorAlert(with: error, on: sut)
    }
}
