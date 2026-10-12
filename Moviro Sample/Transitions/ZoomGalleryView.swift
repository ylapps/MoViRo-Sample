//
//  ZoomGalleryView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

struct ZoomGalleryView: BaseView {

    @State var model: ZoomGalleryModel

    init(model: ZoomGalleryModel) {
        self.model = model
    }

    var body: some View {
        ScrollView {
            Text("Tap a card. On iOS 18 and later the detail grows out of it and shrinks back into it when popped; before that, it is a plain push.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                ForEach(model.cards) { card in
                    Button {
                        model.open(card)
                    } label: {
                        GalleryCardView(card: card)
                    }
                    .buttonStyle(ZoomSourceButtonStyle())
                    .zoomTransitionSource(id: card.id)
                }
            }
            .padding()
        }
        .navigationTitle("Zoom Gallery")
    }
}

// MARK: - Button Style

/// No pressed look. The card is the zoom's source, and the system takes its
/// snapshot at the push — with the plain style, that snapshot is the card
/// dimmed by the press, and the detail grows out of a washed-out tile.
struct ZoomSourceButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

// MARK: - Card View

struct GalleryCardView: View {

    let card: GalleryCard

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(card.color.gradient)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(card.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(12)
            }
    }
}

#Preview {
    NavigationStackRouter(root: ZoomGalleryRouter(), transition: .fullScreen).makeView()
}
