//
//  ZoomDetailView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// The hero fills the top of the screen, edge to edge and square like the
/// card it came from: the zoom scales the whole screen down to the card's
/// width, so a hero that starts at the top edge lands exactly on the card,
/// and nothing of the screen reaches above it on the way in or out.
struct ZoomDetailView: BaseView {

    @State var model: ZoomDetailModel

    init(model: ZoomDetailModel) {
        self.model = model
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Rectangle()
                    .fill(model.card.color.gradient)
                    .aspectRatio(1, contentMode: .fit)

                VStack(spacing: 24) {
                    Text(model.card.title)
                        .font(.largeTitle.bold())

                    Text("Pushed with .zoom(sourceID:). Pop with the back button, a swipe, or Close — each shrinks the screen back into its card.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.secondary)

                    Button("Close (Pop)") {
                        model.close()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbarBackground(.hidden, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStackRouter(root: ZoomDetailRouter(card: GalleryCard.all[3]), transition: .fullScreen).makeView()
}
