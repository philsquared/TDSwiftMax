import XCTest

// Makes the Action enum comparable with ==
// We put it here because it is specific to testing, but if we felt it was more generally useful
// we could promote it to the main project
extension Action: Equatable {}
func == (lhs: Action, rhs : Action) -> Bool {
    switch lhs {
    case .NoMove: if case .NoMove = rhs { return true } else { return false }
    case .Win: if case .Win = rhs { return true } else { return false }
    case .MoveTo(let toLhs ): if case .MoveTo( let toRhs ) = rhs { return toLhs == toRhs } else { return false }
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
