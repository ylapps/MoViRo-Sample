//
//  ColorPickerView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// Demonstrates `ModalRouterWithCloseReason`: picking a color closes the sheet
/// with that color, Cancel closes it with none.
struct ColorPickerView: BaseView {

    @State var model: ColorPickerModel

    init(model: ColorPickerModel) {
        self.model = model
    }

    var body: some View {
        NavigationStack {
            List(model.colors) { color in
                Button {
                    model.pick(color)
                } label: {
                    Label {
                        Text(color.title)
                    } icon: {
                        Image(systemName: "circle.fill")
                            .foregroundStyle(color.color)
                    }
                }
            }
            .navigationTitle("Favorite Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        model.cancel()
                    }
                }
            }
        }
    }
}

#Preview {
    ModalPreviewRouter {
        ColorPickerRouter(onWillCloseWithReason: nil)
    }
    .makeView()
}
