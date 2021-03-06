import UIKit
import XCTest
import AAsyncImageLoader

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadImageWithSuccess() {
        let expectation = self.expectation(description: "Image Data With Success")

        let imageSrc = "https://www.academiedugout.fr/images/2733/300-300/claire-heitzler_retouche_01.jpg"
        let imageUrl = URL(string: imageSrc)!

        let asyncImageLoader = AAsyncImageLoader(configuration: AAsyncImageLoaderConfiguration())
            .withUrl(url: imageUrl) {
                image, error in

                XCTAssertNil(error, "error should be nil")
                XCTAssertNotNil(image, "image should not be nil")

                expectation.fulfill()
            }
            .load()

        waitForExpectations(timeout: 3) {
            error in
            if let error = error {
                print(error)
            }
            _ = asyncImageLoader.cancel()
        }
    }

    func testLoadImageWithError() {
        let expectation = self.expectation(description: "Image Data With Error")

        let imageSrc = "https://www.academiedugout.fr/images/2733/300-300/claire-heitzler_retouche_01_404.jpg"
        let imageUrl = URL(string: imageSrc)!
        let asyncImageLoader = AAsyncImageLoader(configuration: AAsyncImageLoaderConfiguration())
            .withUrl(url: imageUrl) {
                image, error in

                XCTAssertNotNil(error, "error should be not nil")
                XCTAssertNil(image, "image should be nil")

                expectation.fulfill()
            }
            .load()

        waitForExpectations(timeout: 3) {
            error in
            if let error = error {
                print(error)
            }
            _ = asyncImageLoader.cancel()
        }
    }

    func testLoadImageViewWithSuccess() {
        let expectation = self.expectation(description: "UIImageView Data With Success")

        let imageSrc = "https://www.academiedugout.fr/images/2733/300-300/claire-heitzler_retouche_01.jpg"
        let imageUrl = URL(string: imageSrc)!
        let image = UIImageView()
        image.aail_load(url: imageUrl, placeholder: nil) {
            image, error in

            XCTAssertNil(error, "error should be nil")
            XCTAssertNotNil(image, "image should not be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 3) {
            error in
            if let error = error {
                print(error)
            }
            image.aail_cancel()
        }
    }

    func testLoadImageViewWithError() {
        let expectation = self.expectation(description: "UIImageView Data With Error")

        let imageSrc = "https://www.academiedugout.fr/images/2733/300-300/claire-heitzler_retouche_01_404.jpg"
        let imageUrl = URL(string: imageSrc)!
        let image = UIImageView()
        image.aail_load(url: imageUrl, placeholder: nil) {
            image, error in

            XCTAssertNotNil(error, "error should be not nil")
            XCTAssertNil(image, "image should be nil")

            expectation.fulfill()
        }

        waitForExpectations(timeout: 3) {
            error in
            if let error = error {
                print(error)
            }
            image.aail_cancel()
        }
    }
    
    func testLoadImageAndCancel() {
        // This is not easy to test

//        let expectation = expectationWithDescription("Image Data With Error")
//
//        let imageSrc = "https://www.academiedugout.fr/images/52287/948-580/fotolia_12224852_subscription_xl.jpg"
//        let imageUrl = NSURL(string: imageSrc)!
//        let image = UIImageView()
//        image.aail_load(imageUrl, placeholder: nil) {
//            image, error in
//
//            XCTAssertNotNil(error, "error should be not nil")
//            XCTAssertNil(image, "image should be nil")
//
//            expectation.fulfill()
//        }
//        image.aail_cancel()
//
//        waitForExpectationsWithTimeout(3) {
//            error in
//            if let error = error {
//                print(error.description)
//            }
//        }
    }
    
    func testLoadImageViewAndCancel() {
        
    }
}
