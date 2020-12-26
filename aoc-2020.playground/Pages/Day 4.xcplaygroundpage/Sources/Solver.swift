import Foundation

public struct Height {
    let value: Int
    let unit: String

    var isValid: Bool {
        switch unit {
        case "cm": return (150...193).contains(value)
        case "in": return (59...76).contains(value)
        default: return false
        }
    }
}

public struct HairColor {

    static let hexCharacters = CharacterSet(charactersIn: "1234567890abcdefABCDEF")

    let rawValue: String

    var isValid: Bool {
        guard
            rawValue.first == "#",
            rawValue.dropFirst().count == 6,
            String(rawValue.dropFirst()).rangeOfCharacter(from: HairColor.hexCharacters.inverted) == nil
        else { return false }
        return true
    }
}

public enum EyeColor: String {
    case amb, blu, brn, gry, grn, hzl, oth
}

public struct Passport: StringInitable {

    struct Field: StringInitable {

        enum FieldType: String {
            case byr
            case iyr
            case eyr
            case hgt
            case hcl
            case ecl
            case pid
            case cid
        }

        var fieldType: FieldType
        var value: String

        init?(_ string: String) {
            let parts = string.split(separator: ":").map { String($0) }
            guard let fieldType = FieldType(rawValue: parts[0]) else { return nil }
            self.fieldType = fieldType
            self.value = parts[1]
        }

        var isValid: Bool {
            switch self.fieldType {
            case .byr:
                guard let intValue = Int(value) else { return false }
                return (1920...2002).contains(intValue)
            case .iyr:
                guard let intValue = Int(value) else { return false }
                return (2010...2020).contains(intValue)
            case .eyr:
                guard let intValue = Int(value) else { return false }
                return (2020...2030).contains(intValue)
            case .hgt:
                guard let intValue = Int(value.dropLast(2)) else { return false }
                switch value.suffix(2) {
                case "cm": return (150...193).contains(intValue)
                case "in": return (59...76).contains(intValue)
                default: return false
                }
            case .hcl:
                let nonHexChars = CharacterSet(charactersIn: "1234567890abcdef").inverted
                return
                    value.count == 7
                    && value.first == "#"
                    && value.dropFirst().lowercased().rangeOfCharacter(from: nonHexChars) == nil
            case .ecl:
                return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
            case .pid:
                let nonNumericChars = CharacterSet(charactersIn: "1234567890").inverted
                return value.count == 9 && value.rangeOfCharacter(from: nonNumericChars) == nil
            case .cid:
                return true
            }
        }
    }


    let fields: [Field]

    var hasRequiredFields: Bool {

        let requiredFields: [Field.FieldType] = [.byr, .iyr, .eyr, .hgt, .hcl, .ecl, .pid]

        let fieldIds = fields.map { $0.fieldType }
        return requiredFields.allSatisfy { fieldIds.contains($0) }
    }

    var isValid: Bool {
        hasRequiredFields && fields.allSatisfy(\.isValid)
    }

    public init?(_ string: String) {
        fields = string
            .split(separator: " ")
            .compactMap { Field.init(String($0)) }
    }
}

public struct Solver {
    public static func solveFirst(input: [Passport]) -> Int {
        return input
            .filter(\.hasRequiredFields)
            .count
    }

    public static func solveSecond(input: [Passport]) -> Int {
        return input
            .filter(\.isValid)
            .count
    }
}
