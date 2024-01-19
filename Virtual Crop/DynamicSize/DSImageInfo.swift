import SwiftUI

struct DynamicSizeImageInfo: Identifiable {
    let id = UUID()
    let uiimage: UIImage
    var scale: CGFloat?
    var offset: CGSize?
    var cropperSize: CGSize? = nil
}
