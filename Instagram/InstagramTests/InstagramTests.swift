//
//  InstagramTests.swift
//  InstagramTests
//
//  Created by Denys Melnykov on 17.02.2021.
//

import XCTest
import UIKit
@testable import Instagram

class InstagramUITests: XCTestCase {
    //MARK: Sistem Under Test
    
    var sut: HomeViewController!
    
    //MARK: TDD Workflow
    // 🔴 Fail
    // 🟢 Success
    // 🔷 Refactoring
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_template() {
        //MARK: Given
        //MARK: When(what's happend)
        //MARK: Then(result)
    }
}
