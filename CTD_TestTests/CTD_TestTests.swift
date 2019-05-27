//
//  CTD_TestTests.swift
//  CTD_TestTests
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import XCTest
@testable import CTD_Test

class CTD_TestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let dataLoadCase = XCTestExpectation(description: "Data loaded correctly")
            DataService().doGetData(completition: { result in
                if result != nil {
                    dataLoadCase.fulfill()
                } else {
                    XCTFail("Data is Empty")
                }
            })
            // Put the code you want to measure the time of here.
        }
    }
    
    func testImageViewModel() {
        let imageModel = ImageModel(id: "id", url: "url", height: 100.0, width: 100.0)
        let imageViewModel = ImageViewModel(imageModel: imageModel)
        XCTAssertEqual(imageModel.url, imageViewModel.imageUrl)
        XCTAssertEqual(imageModel.id, imageViewModel.imageId)
        
        
        let constraint = NSLayoutConstraint()
        let nHeight = imageViewModel.setDimensions(h: constraint)
        XCTAssertNotNil(nHeight)
        XCTAssertEqual(nHeight, 0)
        
        //Message for error results
        imageViewModel.messageForAction(action: .dontLike, result: .error)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
        imageViewModel.messageForAction(action: .like, result: .error)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
        
        //Message for success results
        imageViewModel.messageForAction(action: .dontLike, result: .success)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
        imageViewModel.messageForAction(action: .like, result: .success)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
        
        //Message for fail results
        imageViewModel.messageForAction(action: .like, result: .fail)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
        imageViewModel.messageForAction(action: .dontLike, result: .fail)
        XCTAssertNotNil(imageViewModel.actionResultMessage)
    }
}
