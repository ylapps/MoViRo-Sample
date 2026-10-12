//
//  ZoomGalleryRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol ZoomGalleryRoutable {
    func showZoomGallery()
}

extension ZoomGalleryRoutable where Self: AnyPushRouter {
    func showZoomGallery() {
        pushed = ZoomGalleryRouter()
    }
}

// MARK: - Card

struct GalleryCard: Identifiable, Hashable {
    let id: Int
    let title: String
    let color: Color

    static let all: [GalleryCard] = [
        GalleryCard(id: 0, title: "Dawn", color: .orange),
        GalleryCard(id: 1, title: "Coral", color: .pink),
        GalleryCard(id: 2, title: "Meadow", color: .green),
        GalleryCard(id: 3, title: "Ocean", color: .blue),
        GalleryCard(id: 4, title: "Plum", color: .purple),
        GalleryCard(id: 5, title: "Ember", color: .red),
        GalleryCard(id: 6, title: "Slate", color: .gray),
        GalleryCard(id: 7, title: "Mint", color: .mint)
    ]
}

// MARK: - Interface

@MainActor
protocol ZoomGalleryRouterInterface: ZoomDetailRoutable {}

// MARK: - Model

@Observable
final class ZoomGalleryModel: Model<any ZoomGalleryRouterInterface> {

    let cards = GalleryCard.all

    func open(_ card: GalleryCard) {
        router?.showZoomDetail(card: card)
    }
}

// MARK: - Router

/// A grid of cards. Each card is a zoom transition source, and the detail it
/// opens is pushed with `.zoom(sourceID:)` for the same id.
final class ZoomGalleryRouter: PushRouter<ZoomGalleryView>, ZoomGalleryRouterInterface {

    override func makeModel() -> ZoomGalleryModel {
        ZoomGalleryModel(router: self)
    }
}
