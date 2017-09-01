import Foundation

enum Portal {
    case snake(UInt)
    case ladder(UInt)
}

enum Action {
    case moveTo(UInt)
    case win
    case noMove
}
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

struct Board {
    let size : UInt = 100
    let portals : [UInt : Portal] =
        [
            2 : .ladder(38),
            4 : .ladder(14),
            8 : .ladder(31),
            21 : .ladder(42),
            28 : .ladder(84),
            36 : .ladder(44),
            47 : .snake(26),
            49 : .snake(11),
            51 : .ladder(67),
            56 : .snake(53),
            62 : .snake(18),
            64 : .snake(60),
            71 : .ladder(91),
            80 : .ladder(100),
            87 : .snake(24),
            93 : .snake(73),
            95 : .snake(75),
            98 : .snake(78)
    ]
    func land(on square:UInt)-> Action {
        let finalSquare : UInt = {
            switch portals[square] {
            case .some(.snake(let target)): return target
            case .some(.ladder(let target)): return target
            default: return square
            }
        }()
        switch finalSquare {
        case size: return .win
        case let x where x > size: return .noMove
        default: return .moveTo(finalSquare)
        }
    }
}

let board = Board()

require() | board.land(on:1) == .moveTo(1)
require() | board.land(on:2) == .moveTo(38)
require() | board.land(on:47) == .moveTo(26)
require() | board.land(on:100) == .win
require() | board.land(on:80) == .win
require() | board.land(on:101) == .noMove

enum PlayerColour {
    case Red
    case Green
    case Blue
    case Yellow
}

class Player {
    let colour : PlayerColour
    var square : UInt = 0
    
    init( _ colour : PlayerColour ) {
        self.colour = colour
    }
}

func throwDie() -> UInt {
    return UInt(arc4random_uniform(6))+1
}

struct Turn {
    let player : Player
    let action : Action
}

class Game {
    let players : [Player]
    var currentPlayer = 0
    let board = Board()
    let die : () -> UInt
    init( _ players : [Player], die : @escaping () -> UInt = throwDie) {
        self.players = players
        self.die = die
        // Make sure players all start on the first square
        for p in self.players {
            p.square = 1
        }
    }
    
    func takeTurn() -> Turn {
        let player = players[currentPlayer]
        currentPlayer = currentPlayer + 1
        if currentPlayer == players.count {
            currentPlayer = 0
        }
        
        let moveBy = die()
        let action = board.land(on: player.square+moveBy)

        return Turn( player: player, action: action)
    }
}

// Example game loop
let game = Game([Player(.Red), Player(.Green), Player(.Blue)])
var stillPlaying = false // Set this to true to kick things off
while stillPlaying {
    let turn = game.takeTurn()
    print( "\(turn.player.colour) goes:")
    switch turn.action {
    case .win: print( " - and wins the game!"); stillPlaying = false
    case .noMove: print( " ... and does not move")
    case .moveTo(let target): print (" - and moves to \(target)")
    }
}
