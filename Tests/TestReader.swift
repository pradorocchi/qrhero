import XCTest
@testable import QRhero

class TestReader:XCTestCase {
    private var model:QRhero!
    
    override func setUp() {
        model = QRhero()
    }
    
    func testReturnErrorIfWrongImage() {
        let expect = expectation(description:String())
        DispatchQueue.global(qos:.background).async {
            self.model.read(image:UIImage(), result: { _ in }, error: { _ in
                XCTAssertEqual(Thread.main, Thread.current)
                expect.fulfill()
            })
        }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReturnContentFromValidImage() {
        let expect = expectation(description:String())
        let image:UIImage
        do {
            let data = try Data(contentsOf:Bundle(for:TestReader.self).url(forResource:"qrcode", withExtension:"png")!)
            image = UIImage(data:data)!
        } catch { return XCTFail() }
        DispatchQueue.global(qos:.background).async {
            self.model.read(image:image, result: { result in
                XCTAssertEqual("http://en.m.wikipedia.org", result)
                XCTAssertEqual(Thread.main, Thread.current)
                expect.fulfill()
            })
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
