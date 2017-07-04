import XCTest

// Makes the Action enum comparable with ==
// We put it here because it is specific to testing, but if we felt it was more generally useful
// we could promote it to the main project
extension Action: Equatable {
    static func ==(lhs: Action, rhs: Action) -> Bool {
        switch (lhs,rhs) {
        case (.noMove, .noMove): return true
        case (.noMove, _): return false
        case (.win, .win): return true
        case (.win, _): return false
        case (.moveTo(let lhs), .moveTo(let rhs)): return lhs == rhs
        case (.moveTo, _): return false
        }
    }
}

// Write normal XCTestCase methods here
// But for assertions you can use either Swordfish style or XCTest assertions
// For Swordfish assertions just prefix any == or != expression with require() |
// e.g.:
//   require() | theAnswer() == 42

class SnakesAndLadders_Tests: XCTestCase {
    
    func testBoard() {
        // Copy & paste assertions from playground into here
    }
}
