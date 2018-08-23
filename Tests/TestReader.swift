import XCTest
@testable import QRhero

class TestReader:XCTestCase {
    private var model:QRhero!
    
    override func setUp() {
        super.setUp()
        self.model = QRhero()
    }
    
    func testReturnErrorIfWrongImage() {
        let expect:XCTestExpectation = self.expectation(description:"Not reading")
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            self.model.read(image:UIImage(), result: { (result:String) in }, error: { (error:Error) in
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                expect.fulfill()
            })
        }
        self.waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReturnContentFromValidImage() {
        let expect:XCTestExpectation = self.expectation(description:"Not reading")
        let image:UIImage
        do {
            let data:Data = try Data(contentsOf:Bundle(for:TestReader.self).url(
                forResource:"qrcode", withExtension:"png")!)
            image = UIImage(data:data)!
        } catch let error {
            XCTFail(error.localizedDescription)
            return
        }
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async {
            self.model.read(image:image, result: { (result:String) in
                XCTAssertEqual("http://en.m.wikipedia.org", result, "Invalid result")
                XCTAssertEqual(Thread.current, Thread.main, "Should be main thread")
                expect.fulfill()
            })
        }
        self.waitForExpectations(timeout:1, handler:nil)
    }
}
