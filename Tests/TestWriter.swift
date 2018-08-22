import XCTest
@testable import QRhero

class TestWriter:XCTestCase {
    func testWriteContent() {
        let expect:XCTestExpectation = self.expectation(description:"Not reading")
        let content:String = "lorem ipsum"
        let model:QRhero = QRhero()
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            model.write(content:content) { (image:UIImage) in
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                model.read(image:image, result: { (result:String) in
                    XCTAssertEqual(content, result, "Invalid content")
                    expect.fulfill()
                })
            }
        }
        self.waitForExpectations(timeout:1, handler:nil)
    }
}
