//
//  SessionTests.swift
//  FocusTests
//
//  Created by Jack Radford on 24/01/2024.
//

import XCTest

@testable import Focus

final class SessionTests: XCTestCase {

    private let moc = PersistenceController.previewMoc
    private let calendar = Calendar.current
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSessionDuration() {
        let end = Date.now
        let start = calendar.date(byAdding: .minute, value: -175, to: end)!
        let session = Session(start: start, end: end, insertInto: moc)
        
        let result = session.duration
        
        XCTAssertEqual(result, "2h 55m")
    }
    func testSessionNegativeDuration() {
        let end = Date.now
        let start = calendar.date(byAdding: .minute, value: 175, to: end)!
        let session = Session(start: start, end: end, insertInto: moc)
        
        let result = session.duration
        
        XCTAssertEqual(result, "-2h 55m")
    }
    func testSessionZeroDuration() {
        let now = Date.now
        let session = Session(start: now, end: now, insertInto: moc)
        
        let result = session.duration
        
        XCTAssertEqual(result, "0m")
    }

}
