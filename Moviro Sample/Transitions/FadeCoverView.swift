//
//  FadeCoverView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// The content of a cover presented with `.fullScreen(transition:)`. Home
/// shows through wherever the transition leaves it clear, which is what makes
/// the fade read as a fade over Home rather than a slide-up.
struct FadeCoverView: BaseView {

    @State var model: FadeCoverModel

    init(model: FadeCoverModel) {
        self.model = model
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Image(systemName: model.style.systemImage)
                    .font(.system(size: 48))

                Text("\(model.style.title) Cover")
                    .font(.title)

                Text("Presented as .fullScreen(transition:). The cover itself never slides — its content \(model.style == .fade ? "fades" : "scales") in over Home, and Close runs the same transition backwards before the cover goes.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                Button("Close") {
                    model.dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .foregroundStyle(.white)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ModalPreviewRouter {
        FadeCoverRouter(style: .fade)
    }
    .makeView()
}
