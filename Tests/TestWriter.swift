import XCTest
@testable import QRhero

class TestWriter:XCTestCase {
    func testWriteContent() {
        let expect = expectation(description:"Not reading")
        let content = "lorem ipsum"
        let model = QRhero()
        DispatchQueue.global(qos:.background).async {
            model.write(content:content) { (image) in
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                model.read(image:image, result: { (result) in
                    XCTAssertEqual(content, result, "Invalid content")
                    expect.fulfill()
                })
            }
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
