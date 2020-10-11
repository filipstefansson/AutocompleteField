import XCTest

final class AutocompleteFieldTests: XCTestCase {
    func testWordSuggestions() {
        let textfield = AutocompleteField()
        textfield.suggestionType = .Word
        textfield.suggestions = [
            "George Washington",
            "Thomas Jefferson",
            "John Adams",
            "Theodore Roosevelt",
            "John F. Kennedy",
            "George W. Bush",
        ]
        
        textfield.text = "Geo"
        XCTAssertEqual(textfield.suggestion, "George")
        
        textfield.text = "Ada"
        XCTAssertEqual(textfield.suggestion, nil)
        
        textfield.text = "George W"
        XCTAssertEqual(textfield.suggestion, "George W.")
        
        textfield.text = "George W. "
        XCTAssertEqual(textfield.suggestion, "George W. Bush")
        
        textfield.text = "John Adams"
        XCTAssertEqual(textfield.suggestion, "John Adams")
        
        textfield.text = "John Adams A"
        XCTAssertEqual(textfield.suggestion, nil)
        
        textfield.text = ""
        XCTAssertEqual(textfield.suggestion, nil)
    }
    
    func testSetenceSuggestions() {
        let textfield = AutocompleteField()
        textfield.suggestions = [
            "George Washington",
            "Thomas Jefferson",
            "John Adams",
            "Theodore Roosevelt",
            "John F. Kennedy",
            "George W. Bush",
        ]
        
        textfield.text = "Geo"
        XCTAssertEqual(textfield.suggestion, "George Washington")
        
        textfield.text = "Ada"
        XCTAssertEqual(textfield.suggestion, nil)
        
        textfield.text = "George W"
        XCTAssertEqual(textfield.suggestion, "George Washington")
        
        textfield.text = "George W. "
        XCTAssertEqual(textfield.suggestion, "George W. Bush")
        
        textfield.text = "John Adams"
        XCTAssertEqual(textfield.suggestion, "John Adams")
        
        textfield.text = "John Adams A"
        XCTAssertEqual(textfield.suggestion, nil)
        
        textfield.text = ""
        XCTAssertEqual(textfield.suggestion, nil)
    }

    static var allTests = [
        ("testWordSuggestions", testWordSuggestions),
        ("testSetenceSuggestions", testSetenceSuggestions),
    ]
}
