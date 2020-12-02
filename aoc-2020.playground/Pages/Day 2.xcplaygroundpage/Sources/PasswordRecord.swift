import Foundation

public struct PasswordRecord: StringInitable {
    public let ruleLetter: Character
    public let ruleRange: ClosedRange<Int>
    public let password: String

    public init?(_ string: String) {
        let parts = string.split(separator: " ")
        guard parts.count == 3 else { return nil }

        // Extract the range.
        let rangeParts = parts[0].split(separator: "-").compactMap { Int($0) }
        guard rangeParts.count == 2 else { return nil }
        ruleRange = rangeParts[0]...rangeParts[1]

        // Extract rule letter.
        guard let letter = parts[1].unicodeScalars.first else { return nil }
        ruleLetter = Character(letter)

        // Extract the password.
        password = String(parts[2])
    }

    public var isValid: Bool {
        let histogram: [Character: Int] = password.reduce(into: [:]) { result, letter in
            result[letter, default: 0] += 1
        }
        let ruleLetterCount = histogram[ruleLetter, default: 0]
        return ruleRange.contains(ruleLetterCount)
    }

    public var isValidAltRule: Bool {
        let chars: [Character] = password.map { $0 }
        let low = ruleRange.lowerBound - 1   // Remember: the puzzle states that the ranges
        let high = ruleRange.upperBound - 1  //           are 1-indexed.
        return (chars[low] == ruleLetter) != (chars[high] == ruleLetter)
    }
}
