import SwiftUI

fileprivate let values: [CGFloat] = [
    100, 150, 200, 250, 300
]

struct DynamicSizeImageVisualizerView: View {
    let imageInfo: DynamicSizeImageInfo
    private let value: CGFloat = values.randomElement()!
    private var size: CGSize { CGSize(width: value, height: value) }

    var body: some View {
        Image(uiImage: imageInfo.uiimage)
            .scaleEffect(imageInfo.scale ?? 1)
            .offset(imageInfo.offset ?? .zero)
            .scaleEffect(getReScaleFactor() ?? 1)
            .frame(width: size.width, height: size.height)
            .clipShape(Circle())
            .contentShape(Circle())
    }

    func getReScaleFactor() -> CGFloat? {
        guard let cropperSize = imageInfo.cropperSize else { return nil }

        let scaleHeight = size.height / cropperSize.height
        let scaleWidth = size.width / cropperSize.width

        return (scaleHeight + scaleWidth) / 2
    }
}

#Preview {
    DynamicSizeImageVisualizerView(
        imageInfo: .init(uiimage: UIImage(named:"image-900-500")!,
                         scale: nil, offset: nil)
    )
}
