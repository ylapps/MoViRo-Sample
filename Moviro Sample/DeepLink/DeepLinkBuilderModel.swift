//
//  DeepLinkBuilderModel.swift
//  Moviro Sample
//

import Moviro

// MARK: - Model

@Observable
final class DeepLinkBuilderModel: Model<any DeepLinkBuilderRouterInterface> {

    // MARK: State

    /// Kept in `UserDefaults`: opening from the root replaces this screen,
    /// so the link has to survive it.
    private(set) var link: DeepLink

    var isEmpty: Bool { link.steps.isEmpty }

    var animatesOnlyLast: Bool {
        get { link.animatesOnlyLast }
        set {
            link.animatesOnlyLast = newValue
            save()
        }
    }

    // MARK: Initialization

    override init(router: (any DeepLinkBuilderRouterInterface)?) {
        link = Self.load()
        super.init(router: router)
    }

    // MARK: Actions

    func canAppend(_ step: DeepLinkStep) -> Bool {
        DeepLinkStep.canAppend(step, after: link.steps.last)
    }

    func append(_ step: DeepLinkStep) {
        guard canAppend(step) else { return }
        link.steps.append(step)
        save()
    }

    func remove(at offsets: IndexSet) {
        link.steps.remove(atOffsets: offsets)
        trimToValid()
        save()
    }

    func move(from source: IndexSet, to destination: Int) {
        link.steps.move(fromOffsets: source, toOffset: destination)
        trimToValid()
        save()
    }

    func loadExample() {
        link = .example
        save()
    }

    func clear() {
        link.steps.removeAll()
        save()
    }

    func openFromRoot() {
        guard link.isValid else { return }
        router?.openFromRoot(link)
    }

    func openFromHere() {
        guard link.isValid else { return }
        router?.openFromHere(link)
    }

    // MARK: Private

    /// Removing or moving a step can leave a push with nothing to push onto;
    /// the link is cut just before the first such step.
    private func trimToValid() {
        var previous: DeepLinkStep?
        for (index, step) in link.steps.enumerated() {
            guard DeepLinkStep.canAppend(step, after: previous) else {
                link.steps.removeSubrange(index...)
                return
            }
            previous = step
        }
    }

    private static let defaultsKey = "deepLinkBuilder.link"

    private static func load() -> DeepLink {
        guard let data = UserDefaults.standard.data(forKey: defaultsKey),
              let link = try? JSONDecoder().decode(DeepLink.self, from: data) else {
            return .example
        }
        return link
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(link) else { return }
        UserDefaults.standard.set(data, forKey: Self.defaultsKey)
    }
}
