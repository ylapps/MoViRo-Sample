//
//  DetailModel.swift
//  Moviro Sample
//

import Moviro

// MARK: - Model

@Observable
final class DetailModel: Model<any DetailRouterInterface> {

    // MARK: Actions

    func showSheet() {
        router?.showSheet()
    }

    func showFullScreen() {
        router?.showFullScreen()
    }

    func showPopover() {
        router?.showPopover()
    }

    /// `close()` comes from `ClosableRouter`, so the model can pop its screen
    /// without knowing which router it has.
    func close() {
        router?.close()
    }
}
