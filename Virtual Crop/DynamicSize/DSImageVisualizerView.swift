import SwiftUI

struct DynamicSizeImageVisualizerView: View {
    let imageInfo: DynamicSizeImageInfo
    private var size: CGSize { DynamicSizeHomeView.cropSize }

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
    DynamicSizeImageVisualizerView(
        imageInfo: .init(uiimage: UIImage(named:"image-900-500")!,
                         scale: nil, offset: nil)
    )
}
