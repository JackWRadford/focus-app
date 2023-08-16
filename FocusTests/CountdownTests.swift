//
//  CountdownTests.swift
//  FocusTests
//
//  Created by Jack Radford on 16/08/2023.
//

import XCTest

@testable import Focus

final class CountdownTests: XCTestCase {

    @MainActor
    func testStart() {
        let context = PersistenceController.previewMoc
        let viewModel = CountdownViewModel(moc: context)
        viewModel.reset()
        
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        viewModel.start()
        XCTAssertTrue(viewModel.isActive)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.reset()
    }
    
    @MainActor
    func testPause() {
        let context = PersistenceController.previewMoc
        let viewModel = CountdownViewModel(moc: context)
        viewModel.reset()
        
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        viewModel.start()
        viewModel.pause()
        XCTAssertTrue(viewModel.isActive)
        XCTAssertTrue(viewModel.isPaused)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.reset()
    }
    
    @MainActor
    func testResume() {
        let context = PersistenceController.previewMoc
        let viewModel = CountdownViewModel(moc: context)
        viewModel.reset()
        
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        viewModel.start()
        viewModel.pause()
        XCTAssertTrue(viewModel.isActive)
        XCTAssertTrue(viewModel.isPaused)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.resume()
        XCTAssertTrue(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.reset()
    }
    
    @MainActor
    func testReset() {
        let context = PersistenceController.previewMoc
        let viewModel = CountdownViewModel(moc: context)
        viewModel.reset()
        
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        viewModel.start()
        viewModel.reset()
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertEqual(viewModel.stage, .focus)
    }
    
    @MainActor
    func testNextStage() {
        let context = PersistenceController.previewMoc
        let viewModel = CountdownViewModel(moc: context)
        viewModel.reset()
        viewModel.breaksInterval = 2
                
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertFalse(viewModel.isActive)
        XCTAssertFalse(viewModel.isPaused)
        viewModel.start()
        XCTAssertTrue(viewModel.isActive)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.nextStage()
        XCTAssertFalse(viewModel.isActive)
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertEqual(viewModel.stage, .shortBreak)
        viewModel.nextStage()
        XCTAssertFalse(viewModel.isActive)
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertEqual(viewModel.stage, .focus)
        viewModel.nextStage()
        XCTAssertFalse(viewModel.isActive)
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertEqual(viewModel.stage, .longBreak)
        viewModel.nextStage()
        XCTAssertFalse(viewModel.isActive)
        XCTAssertNil(viewModel.timeDiff)
        XCTAssertEqual(viewModel.stage, .focus)
    }
}
