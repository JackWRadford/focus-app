//
//  FormatterTests.swift
//  FocusTests
//
//  Created by Jack Radford on 16/08/2023.
//

import XCTest

@testable import Focus

final class FormatterTests: XCTestCase {
    
    func testTimeStringFromWithUnits() {
        let diff: TimeInterval = 196126
        let showUnits = true
                        
        let resultSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.second])
        let resultMinSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.minute, .second])
        let resultHourMinSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.hour, .minute, .second])
        
        XCTAssertEqual(resultSec, "196,126s")
        XCTAssertEqual(resultMinSec, "3,268m 46s")
        XCTAssertEqual(resultHourMinSec, "54h 28m 46s")
    }
    
    func testTimeStringFromWithoutUnits() {
        let diff: TimeInterval = 196126
        let showUnits = false
                        
        let resultSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.second])
        let resultMinSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.minute, .second])
        let resultHourMinSec = timeStringFrom(diff: diff, showUnits: showUnits, allowedUnits: [.hour, .minute, .second])
        
        XCTAssertEqual(resultSec, "196,126")
        XCTAssertEqual(resultMinSec, "3,268:46")
        XCTAssertEqual(resultHourMinSec, "54:28:46")
    }
}
