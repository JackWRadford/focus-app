//
//  FormatterTests.swift
//  FocusTests
//
//  Created by Jack Radford on 16/08/2023.
//

import XCTest

@testable import Focus

final class FormatterTests: XCTestCase {

    func testFormatDate() {
        let components = DateComponents(year: 2000, month: 3, day: 23, hour: 6, minute: 15)
        let date = Calendar.current.date(from: components)
        
        let result = formatDate(date: date)
        
        XCTAssertEqual(result, "23/03/2000, 6:15")
    }
    
    func testFormatDateWithNilDate() {
        let result = formatDate(date: nil)
        
        XCTAssertEqual(result, "n.d.")
    }
    
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
