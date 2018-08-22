import XCTest
@testable import QRhero

class TestWriter:XCTestCase {
    func testWriteContent() {
        let content:String = "lorem ipsum"
        let image:UIImage? = QRhero().write(content:content)
        XCTAssertNotNil(image, "Failed to write")
        if image != nil {
            var result:String?
            do { try result = QRhero().read(image:image!) } catch { }
            XCTAssertNotNil(result, "No content")
            XCTAssertEqual(content, result, "Invalid content")
        }
    }
}
