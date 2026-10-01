//
//  DetailView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// A pushed detail screen. Demonstrates presenting modals from a pushed context
/// and popping back with `close()`.
struct DetailView: BaseView {

    @State var model: DetailModel

    init(model: DetailModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section("Modal from Detail") {
                Button("Present Sheet") {
                    model.showSheet()
                }
                Button("Present Full Screen") {
                    model.showFullScreen()
                }
                Button("Present Popover") {
                    model.showPopover()
                }
            }

            Section {
                Button("Close (Pop)", role: .destructive) {
                    model.close()
                }
            }
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    NavigationStackRouter(root: DetailRouter(), transition: .fullScreen).makeView()
}
