//
//  AnalyticsTests.swift
//  FocusTests
//
//  Created by Jack Radford on 16/08/2023.
//

import XCTest

@testable import Focus

final class AnalyticsTests: XCTestCase {
    
    /// Test Session data. Starts at the end of the day on 23/03/2000.
    /// Creates 10 sessions, 61 minutes in duration, where the end dates of each are 1 hours apart.
    private var sessionsTestData: [Session] {
        var sessions: [Session] = []
        let calendar = Calendar.current
        let endDate = getDateFrom(year: 2000, month: 3, day: 23, hour: 0, minute: 0).endOfDay
        for index in 0..<10 {
            let end = calendar.date(byAdding: .hour, value: -4 * index, to: endDate)!
            let start = calendar.date(byAdding: .minute, value: -61, to: end)!
            let newSession = createSession(from: start, to: end)
            sessions.append(newSession)
        }
        
        return sessions
    }
    
    /// Constructs a Date from the given `year`, `month`, `day`, `hour`, and `minute` components
    private func getDateFrom(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date {
        let calendar = Calendar.current
        let now = Date.now
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components)!
    }
    
    /// Create a Session from `start` and `end` dates
    private func createSession(from start: Date, to end: Date) -> Session {
        let moc = PersistenceController.previewMoc
        let newSession = Session(context: moc)
        newSession.id = UUID()
        newSession.startDate = start
        newSession.endDate = end
        return newSession
    }
    
    func testBestSession() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .year
        avm.sessions = sessionsTestData
        
        let result = avm.bestSession()
        
        XCTAssertEqual(result, "1h 1m")
    }
    
    func testTotalTime() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .year
        avm.sessions = sessionsTestData
        
        let result = avm.totalTime()
        
        XCTAssertEqual(result, "10h 10m")
    }
    
    func testUnitForTimeFrameDay() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .day
        
        let result = avm.unitForTimeFrame()
        
        XCTAssertEqual(result, .hour)
    }
    func testUnitForTimeFrameWeek() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .week
        
        let result = avm.unitForTimeFrame()
        
        XCTAssertEqual(result, .day)
    }
    func testUnitForTimeFrameMonth() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .month
        
        let result = avm.unitForTimeFrame()
        
        XCTAssertEqual(result, .day)
    }
    func testUnitForTimeFrameYear() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .year
        
        let result = avm.unitForTimeFrame()
        
        XCTAssertEqual(result, .month)
    }
    
    func testFocusSessionDataForDayTimeFrame() {
        let moc = PersistenceController.previewMoc
        let avm = AnalyticsViewModel(moc: moc)
        avm.timeFrame = .day
        avm.sessions = [
            createSession(
                from: getDateFrom(year: 2000, month: 3, day: 23, hour: 10, minute: 0),
                to: getDateFrom(year: 2000, month: 3, day: 23, hour: 11, minute: 30)),
            createSession(
                from: getDateFrom(year: 2000, month: 3, day: 23, hour: 23, minute: 0),
                to: getDateFrom(year: 2000, month: 3, day: 24, hour: 1, minute: 15)),
        ]
        
        let result = avm.focusSessionData()
        
        
        let expectedResult: [FocusSession] = [
            .init(
                date: getDateFrom(year: 2000, month: 3, day: 23, hour: 10, minute: 0), duration: 60),
            .init(
                date: getDateFrom(year: 2000, month: 3, day: 23, hour: 11, minute: 0), duration: 30),
            .init(
                date: getDateFrom(year: 2000, month: 3, day: 23, hour: 23, minute: 0), duration: 60),
            .init(
                date: getDateFrom(year: 2000, month: 3, day: 24, hour: 0, minute: 0), duration: 60),
            .init(
                date: getDateFrom(year: 2000, month: 3, day: 24, hour: 1, minute: 0), duration: 15),
            .init(date: avm.timeFrameDates.start, duration: 0),
            .init(date: avm.timeFrameDates.end, duration: 0),
        ]
        for index in 0..<result.count {
            guard result.count == expectedResult.count else {
                XCTFail("Result and Expected arrays have different counts:\nResult: \(result.count)\nExpected: \(expectedResult.count)")
                return
            }
            let resultObj = result[index]
            let expectedObj = expectedResult[index]
            XCTAssertEqual(resultObj.date, expectedObj.date)
            XCTAssertEqual(resultObj.duration, expectedObj.duration)
        }
    }
}
