import XCTest
import QRhero

class TestReader:XCTestCase {
    func testReturnErrorIfWrongImage() {
        let model:QRhero = QRhero()
        XCTAssertThrowsError(try model.read(image:UIImage()), "Failed to throw")
    }
}
