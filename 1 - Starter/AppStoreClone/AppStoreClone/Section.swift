import Foundation

struct Section: Hashable {
    let id = UUID()
    let kind: Kind
    let title: String
    let subtitle: String
    let items: [Item]

    init(kind: Kind, title: String = "", subtitle: String = "", items: [Item] = []) {
        self.kind = kind
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }

    enum Today: String {
        case header
        case app
    }

    enum App: String {
        case featured
        case large
        case medium
        case small
    }

    struct Kind: RawRepresentable, Hashable {
        typealias RawValue = String
        var rawValue: String

        init(rawValue: String) {
            self.rawValue = rawValue
        }

        static let todayHeader = Kind(rawValue: Section.Today.header.rawValue)
        static let todayApp = Kind(rawValue: Section.Today.app.rawValue)
        static let featured = Kind(rawValue: Section.App.featured.rawValue)
        static let large = Kind(rawValue: Section.App.large.rawValue)
        static let medium = Kind(rawValue: Section.App.medium.rawValue)
        static let small = Kind(rawValue: Section.App.small.rawValue)
    }
}
