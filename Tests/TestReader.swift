import XCTest
@testable import QRhero

class TestReader:XCTestCase {
    private var model:QRhero!
    
    override func setUp() {
        super.setUp()
        model = QRhero()
    }
    
    func testReturnErrorIfWrongImage() {
        let expect = expectation(description:"Not reading")
        DispatchQueue.global(qos:.background).async {
            self.model.read(image:UIImage(), result: { (_) in }, error: { (_) in
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                expect.fulfill()
            })
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReturnContentFromValidImage() {
        let expect = expectation(description:"Not reading")
        let image:UIImage
        do {
            let data = try Data(contentsOf:Bundle(for:TestReader.self).url(forResource:"qrcode", withExtension:"png")!)
            image = UIImage(data:data)!
        } catch let error {
            XCTFail(error.localizedDescription)
            return
        }
        DispatchQueue.global(qos:.background).async {
            self.model.read(image:image, result: { (result) in
                XCTAssertEqual("http://en.m.wikipedia.org", result, "Invalid result")
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                expect.fulfill()
            })
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
