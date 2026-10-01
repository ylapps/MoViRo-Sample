//
//  DetailRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol DetailRoutable {
    func showDetail()
}

extension DetailRoutable where Self: AnyPushRouter {
    func showDetail() {
        pushed = DetailRouter()
    }
}

// MARK: - Interface

@MainActor
protocol DetailRouterInterface:
    ClosableRouter,
    SheetRoutable,
    FullScreenRoutable,
    PopoverRoutable {}

// MARK: - Router

/// Push router for the detail screen. Presents each modal transition and pops
/// itself through `ClosableRouter.close()`.
final class DetailRouter: PushRouter<DetailView>, DetailRouterInterface {

    override func makeModel() -> DetailModel {
        DetailModel(router: self)
    }
}
