//
//  DeepLinkBuilderView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// Composes a chain of pushes and presentations and opens it in one go.
struct DeepLinkBuilderView: BaseView {

    @State var model: DeepLinkBuilderModel

    init(model: DeepLinkBuilderModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section {
                if model.isEmpty {
                    Text("No steps yet. Add some below.")
                        .foregroundStyle(.secondary)
                }
                ForEach(Array(model.link.steps.enumerated()), id: \.offset) { index, step in
                    Label("\(index + 1). \(step.title)", systemImage: step.systemImage)
                }
                .onDelete { model.remove(at: $0) }
                .onMove { model.move(from: $0, to: $1) }
            } header: {
                Text("Steps")
            } footer: {
                Text("Each step opens from where the one before it left off. A push needs a stack to land on: Home's, or the one a \"with Stack\" step brings.")
            }

            Section("Add Step") {
                ForEach(DeepLinkStep.allCases) { step in
                    Button {
                        model.append(step)
                    } label: {
                        Label(step.title, systemImage: step.systemImage)
                    }
                    .disabled(!model.canAppend(step))
                }
            }

            Section {
                Toggle("Only the Last Screen Animates", isOn: $model.animatesOnlyLast)
            } header: {
                Text("Animation")
            } footer: {
                Text("On, every step but the last is put on screen without animation and the link lands at once. Off, every level animates in turn, which takes about half a second per modal.")
            }

            Section {
                Button("Open From Root") {
                    model.openFromRoot()
                }
                Button("Open From Here") {
                    model.openFromHere()
                }
            } header: {
                Text("Open")
            } footer: {
                Text("From Root is what a deep link arriving at the app does: every router of the chain is created and linked before anything is on screen, and the stack above Home is replaced with it. From Here hangs the same chain off this screen.")
            }
            .disabled(model.isEmpty)

            Section {
                Button("Load Example") {
                    model.loadExample()
                }
                Button("Clear", role: .destructive) {
                    model.clear()
                }
                .disabled(model.isEmpty)
            }
        }
        .navigationTitle("Deep Link Builder")
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    NavigationStackRouter(root: DeepLinkBuilderRouter(root: HomeRouter()), transition: .fullScreen).makeView()
}
