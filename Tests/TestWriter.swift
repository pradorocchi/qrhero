import XCTest
@testable import QRhero

class TestWriter:XCTestCase {
    func testWriteContent() {
        let expect = expectation(description:String())
        let model = QRhero()
        DispatchQueue.global(qos:.background).async {
            model.write(content:"lorem ipsum") { image in
                XCTAssertEqual(Thread.main, Thread.current)
                model.read(image:image, result: { result in
                    XCTAssertEqual("lorem ipsum", result)
                    expect.fulfill()
                })
            }
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
