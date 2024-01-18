import SwiftUI

struct ContentView: View {
    private let uiimage = UIImage(named: "image-900-500")!
    @State private var info: CropperEditorView.Output = .init(scale: 1, offset: .zero)

    var body: some View {
        VStack {
            CropperEditorView(input: .from(uiimage), output: $info)
        }
    }
}

#Preview {
    ContentView()
}
