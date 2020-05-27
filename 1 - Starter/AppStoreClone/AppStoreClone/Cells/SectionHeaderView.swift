import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let kind = String(describing: SectionHeaderView.self)
    static let reuseIdentifier = String(describing: SectionHeaderView.self)
    static let nib = UINib(nibName: String(describing: SectionHeaderView.self), bundle: nil)
}
