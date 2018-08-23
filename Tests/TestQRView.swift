import XCTest
@testable import QRhero

class TestQRView:XCTestCase {
    private var view:QRView!
    private var delegate:MockDelegate!

    override func setUp() {
        super.setUp()
        view = QRView()
        delegate = MockDelegate()
        view.delegate = delegate
        view.viewDidLoad()
    }
    
    func testCallsCancel() {
        let expect = expectation(description:"Not called")
        delegate.onCancel = { expect.fulfill() }
        view.doCancel()
        waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReadNotifiesDelegate() {
        let expect = expectation(description:"Not called")
        delegate.onRead = {
            XCTAssertEqual(Thread.current, Thread.main, "Not main thread")
            expect.fulfill()
        }
        DispatchQueue.global(qos:.background).async { self.view.read(content:String()) }
        waitForExpectations(timeout:1, handler:nil)
    }
}
