import XCTest
@testable import QRhero

class TestWriter:XCTestCase {
    func testWriteContent() {
        let content:String = "lorem ipsum"
        let model:QRhero = QRhero()
        let image:UIImage? = model.write(content:content)
        XCTAssertNotNil(image, "Failed to write")
        if image != nil {
            let expect:XCTestExpectation = self.expectation(description:"Not reading")
            model.read(image:image!, result: { (result:String) in
                XCTAssertEqual(content, result, "Invalid content")
                expect.fulfill()
            })
            self.waitForExpectations(timeout:1, handler:nil)
        }
    }
}
