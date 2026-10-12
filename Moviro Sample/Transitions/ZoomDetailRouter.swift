//
//  ZoomDetailRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol ZoomDetailRoutable {
    func showZoomDetail(card: GalleryCard)
}

extension ZoomDetailRoutable where Self: AnyPushRouter {
    func showZoomDetail(card: GalleryCard) {
        pushed = ZoomDetailRouter(card: card)
    }
}

// MARK: - Model

@Observable
final class ZoomDetailModel: Model<ZoomDetailRouter> {

    let card: GalleryCard

    init(card: GalleryCard, router: ZoomDetailRouter) {
        self.card = card
        super.init(router: router)
    }

    func close() {
        router?.close()
    }
}

// MARK: - Router

/// Pushed with `.zoom(sourceID:)`: the screen grows out of the gallery card
/// marked `zoomTransitionSource(id:)` with the same id, and shrinks back into
/// it on pop. The namespace the two are matched in is the stack's own.
final class ZoomDetailRouter: PushRouter<ZoomDetailView> {

    private let card: GalleryCard

    init(card: GalleryCard) {
        self.card = card
        super.init(transition: .zoom(sourceID: card.id))
    }

    override func makeModel() -> ZoomDetailModel {
        ZoomDetailModel(card: card, router: self)
    }
}
