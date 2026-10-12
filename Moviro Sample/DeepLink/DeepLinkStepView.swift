//
//  DeepLinkStepView.swift
//  Moviro Sample
//

import Moviro

// MARK: - View

/// One screen of an opened deep link: which step it is, the whole link with
/// this step marked, and Close.
struct DeepLinkStepView: BaseView {

    @State var model: DeepLinkStepModel

    init(model: DeepLinkStepModel) {
        self.model = model
    }

    var body: some View {
        List {
            Section {
                VStack(spacing: 12) {
                    Image(systemName: model.context.step.systemImage)
                        .font(.system(size: 40))
                        .foregroundStyle(.tint)
                    Text("Step \(model.context.number) of \(model.context.steps.count)")
                        .font(.title2.bold())
                    Text(model.context.step.title)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
            }

            Section {
                ForEach(Array(model.context.steps.enumerated()), id: \.offset) { index, step in
                    Label("\(index + 1). \(step.title)", systemImage: step.systemImage)
                        .fontWeight(index == model.context.index ? .bold : .regular)
                        .foregroundStyle(index > model.context.index ? .secondary : .primary)
                }
            } header: {
                Text("The Link")
            } footer: {
                Text("The steps after this one are on screen above it. Close each to work back down.")
            }

            Section {
                Button("Close", role: .destructive) {
                    model.close()
                }
            } footer: {
                Text(model.context.closeDescription)
            }
        }
        .navigationTitle("Step \(model.context.number)")
    }
}

#Preview {
    NavigationStackRouter(
        root: DeepLinkPushStepRouter(context: DeepLinkStepContext(index: 1, steps: DeepLink.example.steps)),
        transition: .fullScreen
    )
    .makeView()
}
