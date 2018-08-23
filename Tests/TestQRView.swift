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
    }
    
    func testCallsCancel() {
        let expect:XCTestExpectation = self.expectation(description:"Not called")
        self.delegate.onCancel = { expect.fulfill() }
        self.view.doCancel()
        self.waitForExpectations(timeout:1, handler:nil)
    }
}
