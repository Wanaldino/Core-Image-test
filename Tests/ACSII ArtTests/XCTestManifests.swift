import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ACSII_ArtTests.allTests),
    ]
}
#endif
