//
//  NotesTests.swift
//  NotesTests
//
//  Created by nimik on 05/08/2018.
//  Copyright © 2018 nimik. All rights reserved.
//

import XCTest
@testable import Notes

class NotesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNetwork() {
        let ex = expectation(description: "Expecting a JSON data not nil")
        
        NetworkLayer.shared.getAllNotes { (note, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(note)
            ex.fulfill()
            
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
        
    }
    
    func testTextView(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let noteController = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        let _ = noteController.view
        XCTAssertEqual("", noteController.textView.text)
    }
    
    func testTitle(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let _ = vc.view
        XCTAssertEqual("notesTitle".localized, vc.title)
        
    }
    
    
    
    
    
}
