import XCTest
@testable import QRhero

class TestQRView:XCTestCase {
    private var view:QRView!
    private var delegate:MockDelegate!

    override func setUp() {
        view = QRView()
        delegate = MockDelegate()
        view.delegate = delegate
        view.viewDidLoad()
    }
    
    func testCallsCancel() {
        let expect = expectation(description:String())
        delegate.onCancel = { expect.fulfill() }
        view.doCancel()
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReadNotifiesDelegate() {
        let expect = expectation(description:String())
        delegate.onRead = {
            XCTAssertEqual(Thread.main, Thread.current)
            expect.fulfill()
        }
        DispatchQueue.global(qos:.background).async { self.view.read(content:String()) }
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReadImageWithSuccess() {
        let expect = expectation(description:String())
        let image:UIImage
        if let data = try? Data(contentsOf:
            Bundle(for:TestReader.self).url(forResource:"qrcode", withExtension:"png")!) {
            image = UIImage(data:data)!
        } else { return XCTFail() }
        delegate.onRead = {
            XCTAssertEqual(Thread.main, Thread.current)
            expect.fulfill()
        }
        DispatchQueue.global(qos:.background).async {
            self.view.read(image:image)
        }
        waitForExpectations(timeout:2, handler:nil)
    }
    
    func testReadWrongImage() {
        let expect = expectation(description:String())
        delegate.onError = {
            XCTAssertEqual(Thread.main, Thread.current)
            expect.fulfill()
        }
        DispatchQueue.global(qos:.background).async {
            self.view.read(image:UIImage())
        }
        waitForExpectations(timeout:1, handler:nil)
    }
}
