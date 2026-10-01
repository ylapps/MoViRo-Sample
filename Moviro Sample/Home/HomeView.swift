//
//  HomeView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// Root screen of the sample. Every button forwards to the model, which asks
/// its router for the navigation.
struct HomeView: BaseView {

    @State var model: HomeModel

    init(model: HomeModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section("Push Navigation") {
                Button("Push Detail") {
                    model.showDetail()
                }
                Button("Push Switch Screen") {
                    model.showPushSwitch()
                }
            }

            Section("Modal Navigation") {
                Button("Present Sheet") {
                    model.showSheet()
                }
                Button("Present Full Screen") {
                    model.showFullScreen()
                }
                Button("Present Modal Switch") {
                    model.showModalSwitch()
                }
            }

            Section {
                Button {
                    model.pickColor()
                } label: {
                    LabeledContent("Favorite Color", value: model.favoriteColor?.title ?? "Not Set")
                }
                Button {
                    model.editNickname()
                } label: {
                    LabeledContent("Nickname", value: model.nickname.isEmpty ? "Not Set" : model.nickname)
                }
            } header: {
                Text("Close Reasons")
            } footer: {
                Text("The color picker is a sheet and the nickname editor a pushed screen. Each closes with a reason that Home receives.")
            }

            Section {
                Button("Reset Choices", role: .destructive) {
                    model.resetChoices()
                }
                .disabled(!model.hasChoices)
            } header: {
                Text("Alerts")
            } footer: {
                Text("A confirmation presented through AlertRoutable.")
            }

            Section {
                LabeledContent("Home Appeared", value: model.appearCount.formatted())
            } header: {
                Text("Lifecycle")
            } footer: {
                Text("onAppear runs again when a pushed screen is popped. A sheet or full-screen modal over Home does not make it disappear.")
            }
        }
        .navigationTitle("Home")
    }
}
