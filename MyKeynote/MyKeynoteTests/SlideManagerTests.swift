//
//  SlideManagerTests.swift
//  SlideManagerTests
//
//  Created by SEUNGMIN OH on 2023/07/17.
//

import XCTest

final class MockSquareContentFactory: SlideContentFactory {
    typealias Content = SquareContent

    func create(generator: inout RandomNumberGenerator) -> SquareContent {
        return Content(
            side: 200,
            color: SMColor.black,
            alpha: SMAlpha.ten
        )
    }
}

final class SlideManagerTests: XCTestCase {

    var slideManager: SlideManager!

    override func setUpWithError() throws {

        let generator = SystemRandomNumberGenerator()
        let squareContentFactory = MockSquareContentFactory()
        slideManager = SlideManager(
            generator: generator,
            squareContentFactory: squareContentFactory
        )
    }

    override func tearDownWithError() throws {
        slideManager = nil
    }

    func test_manager의create메서드에서_ContentFactory에따라제대로값이생성되는지() throws {
        let slide = slideManager.createSlide(of: .square)

        let content = slide.content as? SquareContent
        XCTAssertNotNil(content)
        XCTAssertEqual(content?.side, 200)
        XCTAssertEqual(content?.color, .black)
        XCTAssertEqual(content?.alpha, .ten)
    }

    func test_create했을때_manager에제대로저장되는지() throws {
        let slide = slideManager.createSlide(of: .square)

        XCTAssertEqual(slideManager.slideCount, 1)
    }

    func test_create했을때_manager의subscription이제대로동작하는지() throws {
        let slide = slideManager.createSlide(of: .square)

        XCTAssertIdentical(slide.content as? SquareContent, slideManager[0].content as? SquareContent)
    }

    func test_create여러개했을때_manager의subscription이제대로동작하는지() throws {
        let first = slideManager.createSlide(of: .square)
        let second = slideManager.createSlide(of: .square)
        let third = slideManager.createSlide(of: .square)

        XCTAssertEqual(slideManager.slideCount, 3)
        XCTAssertIdentical(first.content as? SquareContent, slideManager[0].content as? SquareContent)
        XCTAssertIdentical(second.content as? SquareContent, slideManager[1].content as? SquareContent)
        XCTAssertIdentical(third.content as? SquareContent, slideManager[2].content as? SquareContent)
    }

}
