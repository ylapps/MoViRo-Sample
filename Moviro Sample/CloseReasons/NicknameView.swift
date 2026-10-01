//
//  NicknameView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// Demonstrates `PushRouterWithCloseReason`: Save pops the screen with the new
/// nickname, Back pops it without one.
struct NicknameView: BaseView {

    @State var model: NicknameModel
    @FocusState private var isFocused: Bool

    init(model: NicknameModel) {
        self.model = model
    }

    var body: some View {
        Form {
            Section {
                TextField("Nickname", text: $model.nickname)
                    .focused($isFocused)
                    .submitLabel(.done)
                    .onSubmit { model.save() }
            } footer: {
                Text("Save closes this screen with the new nickname. Back closes it without one, so Home keeps the old nickname.")
            }
        }
        .navigationTitle("Nickname")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    model.save()
                }
                .disabled(!model.canSave)
            }
        }
        .onAppear { isFocused = true }
    }
}

#Preview {
    NavigationStackRouter(
        root: NicknameRouter(nickname: "Ada", onWillCloseWithReason: nil),
        transition: .fullScreen
    )
    .makeView()
}
