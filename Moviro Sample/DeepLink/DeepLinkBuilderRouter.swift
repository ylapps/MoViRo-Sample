//
//  DeepLinkBuilderRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol DeepLinkBuilderRoutable {
    func showDeepLinkBuilder()
}

extension DeepLinkBuilderRoutable where Self: AnyPushRouter {
    func showDeepLinkBuilder() {
        pushed = DeepLinkBuilderRouter(root: self)
    }
}

// MARK: - Interface

@MainActor
protocol DeepLinkBuilderRouterInterface: AnyObject {

    /// Opens the link the way a deep link arriving at the app does: from the
    /// stack's root, replacing whatever was pushed — this screen included.
    func openFromRoot(_ link: DeepLink)

    /// Opens the link on top of this screen.
    func openFromHere(_ link: DeepLink)
}

// MARK: - Router

final class DeepLinkBuilderRouter: PushRouter<DeepLinkBuilderView>, DeepLinkBuilderRouterInterface {

    /// The root of the stack this screen is pushed on. Weak: the root holds
    /// this router through `pushed`.
    private weak var root: AnyPushRouter?

    init(root: AnyPushRouter) {
        self.root = root
        super.init()
    }

    override func makeModel() -> DeepLinkBuilderModel {
        DeepLinkBuilderModel(router: self)
    }

    func openFromRoot(_ link: DeepLink) {
        guard let root else { return }
        root.pushed = nil
        link.open(from: root)
    }

    func openFromHere(_ link: DeepLink) {
        link.open(from: self)
    }
}
