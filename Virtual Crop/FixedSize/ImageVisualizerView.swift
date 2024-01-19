import SwiftUI

struct FixedSizeImageVisualizerView: View {
    let imageInfo: FixedSizeImageInfo
    private var size: CGSize { FixedSizeHomeView.cropSize }

    var body: some View {
        Image(uiImage: imageInfo.uiimage)
            .scaleEffect(imageInfo.scale ?? 1)
            .offset(imageInfo.offset ?? .zero)
            .frame(width: size.width, height: size.height)
            .clipShape(Circle())
            .contentShape(Circle())
    }
}

#Preview {
    FixedSizeImageVisualizerView(
        imageInfo: .init(uiimage: UIImage(named:"image-900-500")!,
                         scale: nil, offset: nil)
    )
}
