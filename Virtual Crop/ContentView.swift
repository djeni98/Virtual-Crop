import SwiftUI

struct ContentView: View {
    @State private var uiimage = UIImage(named: "image-900-500")!
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero

    var body: some View {
        VStack {
            CropperEditorView(uiimage: $uiimage, scale: $scale, offset: $offset)
        }
    }
}

#Preview {
    ContentView()
}
