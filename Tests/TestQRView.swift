import XCTest
@testable import QRhero

class TestQRView:XCTestCase {
    private var view:QRView!
    private var delegate:MockDelegate!

    override func setUp() {
        super.setUp()
        self.view = QRView()
        self.delegate = MockDelegate()
        self.view.delegate = self.delegate
        self.view.viewDidLoad()
    }
    
    func testCallsCancel() {
        let expect:XCTestExpectation = self.expectation(description:"Not called")
        self.delegate.onCancel = { expect.fulfill() }
        self.view.doCancel()
        self.waitForExpectations(timeout:1, handler:nil)
    }
    
    func testReadNotifiesDelegate() {
        let expect:XCTestExpectation = self.expectation(description:"Not called")
        self.delegate.onRead = {
            XCTAssertEqual(Thread.current, Thread.main, "Not main thread")
            expect.fulfill()
        }
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async { self.view.read(content:String()) }
        self.waitForExpectations(timeout:1, handler:nil)
    }
}
