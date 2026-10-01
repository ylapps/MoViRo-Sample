//
//  NicknameRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol NicknameRoutable {
    func showNicknameEditor(nickname: String, onClose: @escaping (String?) -> Void)
}

extension NicknameRoutable where Self: AnyPushRouter {
    func showNicknameEditor(nickname: String, onClose: @escaping (String?) -> Void) {
        pushed = NicknameRouter(nickname: nickname, onWillCloseWithReason: onClose)
    }
}

// MARK: - Model

@Observable
final class NicknameModel: Model<NicknameRouter> {

    var nickname: String

    var canSave: Bool { !trimmedNickname.isEmpty }

    private var trimmedNickname: String {
        nickname.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    init(nickname: String, router: NicknameRouter) {
        self.nickname = nickname
        super.init(router: router)
    }

    func save() {
        guard canSave else { return }
        router?.requestClose(with: trimmedNickname)
    }
}

// MARK: - Router

/// A pushed screen that closes with a reason. Save pops it through
/// `requestClose(with:)`; the system Back button pops it without calling
/// `requestClose` at all, so the caller's handler does not run.
final class NicknameRouter: PushRouterWithCloseReason<NicknameView, String> {

    private let nickname: String

    init(nickname: String, onWillCloseWithReason: ReasonHandler?) {
        self.nickname = nickname
        super.init(onWillCloseWithReason: onWillCloseWithReason)
    }

    override func makeModel() -> NicknameModel {
        NicknameModel(nickname: nickname, router: self)
    }
}
