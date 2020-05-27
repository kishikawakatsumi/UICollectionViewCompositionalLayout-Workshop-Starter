import Foundation

struct Item: Hashable {
    let id = UUID()
    let tagline: String
    let title: String
    let subtitle: String

    init(tagline: String = "", title: String = "", subtitle: String = "") {
        self.tagline = tagline
        self.title = title
        self.subtitle = subtitle
    }
}
