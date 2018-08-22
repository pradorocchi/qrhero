import XCTest
@testable import QRhero

class TestReader:XCTestCase {
    func testReturnErrorIfWrongImage() {
        XCTAssertThrowsError(try QRhero().read(image:UIImage()), "Failed to throw")
    }
    
    func testReturnContentFromValidImage() {
        let image:UIImage
        do {
            let data:Data = try Data(contentsOf:Bundle(for:TestReader.self).url(
                forResource:"qrcode", withExtension:"png")!)
            image = UIImage(data:data)!
        } catch let error {
            XCTFail(error.localizedDescription)
            return
        }
        let model:QRhero = QRhero()
        var message:String!
        XCTAssertNoThrow(message = try model.read(image:image), "Failed to read")
        XCTAssertEqual("http://en.m.wikipedia.org", message, "Invalid content")
    }
}
