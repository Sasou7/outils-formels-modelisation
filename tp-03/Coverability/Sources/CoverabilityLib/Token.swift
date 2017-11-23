import PetriKit

public enum Token: Comparable, ExpressibleByIntegerLiteral {

    case some(UInt)
    case omega

    public init(integerLiteral value: UInt) {
        self = .some(value)
    }

    public static func ==(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case let (.some(x), .some(y)):
            return x == y
        default:
            return true
        }
    }

    public static func ==(lhs: Token, rhs: UInt) -> Bool {
        return lhs == Token.some(rhs)
    }

    public static func ==(lhs: UInt, rhs: Token) -> Bool {
        return Token.some(lhs) == rhs
    }

    public static func <(lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case let (.some(x), .some(y)):
            return x < y
        case (_, .omega):
            return true
        default:
            return false
        }
    }

}

extension Dictionary where Key == PTPlace, Value == Token {

    public static func >(lhs: Dictionary, rhs: Dictionary) -> Bool {
        guard lhs.keys == rhs.keys else {
            return false
        }

        var hasGreater = false
        for place in lhs.keys {
<<<<<<< HEAD
            guard lhs[place]! <= rhs[place]! else { return false }
=======
            guard lhs[place]! >= rhs[place]! else { return false }
>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
            if lhs[place]! > rhs[place]! {
                hasGreater = true
            }
        }

        return hasGreater
    }

<<<<<<< HEAD
=======
    public static func ==(lhs: Dictionary, rhs: Dictionary) -> Bool {
        guard lhs.keys == rhs.keys else {
            return false
        }

        for place in lhs.keys {
            switch (lhs[place]!, rhs[place]!) {
            case let (.some(x), .some(y)) where x == y:
                continue
            case (.omega, .omega):
                continue
            default:
                return false
            }
        }

        return true
    }

>>>>>>> 2c3313f512f5b80773522eeb89bc8e8cbca58ef8
}

public typealias CoverabilityMarking = [PTPlace: Token]
