import CryptoKit
import XCTest
@testable import Thumbmark

class Thumbmark_Tests: XCTestCase {
    /// Should be able to set a single value for additional components
    func testSetAdditionalComponentsSingleValue() async {
        let components = [MockComponent.self]
        await Thumbmark.instance.setAdditionalComponents(components)
        let value = await Thumbmark.instance.components
        XCTAssertEqual(components.count, value?.count)
    }
    
    /// Should be able to set an array of values for additional components
    func testSetAdditionalComponentsMultipleValues() async {
        let components = [MockComponent.self, MockComponent.self, MockComponent.self]
        await Thumbmark.instance.setAdditionalComponents(components)
        let value = await Thumbmark.instance.components
        XCTAssertEqual(components.count, value?.count)
    }
    
    /// Should be able to set additional components to nil value
    func testSetAdditionalComponentsNil() async {
        let components = [MockComponent.self, MockComponent.self, MockComponent.self]
        await Thumbmark.instance.setAdditionalComponents(components)
        await Thumbmark.instance.setAdditionalComponents(nil)
        let value = await Thumbmark.instance.components
        XCTAssertNil(value)
    }
    
    /// Test that a known/mocked fingerprint produces a steady id.
    func testKnownId() async {
        let fingerprint = MockFingerprint.fingerprint
        let id = MockFingerprint.expectedId
        let value = await Thumbmark.instance.id(using: SHA256.self, withFingerprint: fingerprint)
        XCTAssertEqual(value, id)
    }
}
