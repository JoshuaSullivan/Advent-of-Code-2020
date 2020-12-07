import Foundation

public struct BagRule: StringInitable, CustomStringConvertible {

    public struct InnerBag: StringInitable, CustomStringConvertible {
        let count: Int
        let color: String

        public init?(_ string: String) {
            let words = string.split(separator: " ")
            guard
                words.count >= 3,
                let count = Int(words[0])
            else { return nil }
            self.count = count
            self.color = words[1...2].joined(separator: " ")
        }

        public var description: String {
            "\(count) \(color) \(count == 1 ? "bag" : "bags")"
        }
    }

    let outerBagColor: String
    let innerBags: [InnerBag]

    public init?(_ string: String) {
        let words = string.split(separator: " ")
        outerBagColor = words[0...1].joined(separator: " ")
        guard words[3] == "contain" else {
            fatalError("Unexpected format.")
        }
        let innerWords = Array(words.dropFirst(4))
        innerBags = (0..<innerWords.count / 4).compactMap {
            let index = $0 * 4
            return InnerBag(innerWords[index..<index+3].joined(separator: " "))
        }
    }

    public var description: String {
        if innerBags.isEmpty {
            return "\(outerBagColor) bags contain no bags."
        } else {
            return "\(outerBagColor) bags contain \(innerBags.map(\.description).joined(separator: ", "))."
        }
    }
}

public struct Solver {
    public static func solveFirst(input: [BagRule], key: String) -> Int {

    }

    private func find(rules: [BagRule], containing color: String) -> [BagRule] {
        rules.filter { $0.innerBags.map(\.color).contains(color) }
    }
}
