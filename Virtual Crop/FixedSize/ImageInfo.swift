import SwiftUI

struct FixedSizeImageInfo: Identifiable {
    let id = UUID()
    let uiimage: UIImage
    var scale: CGFloat?
    var offset: CGSize?
}
