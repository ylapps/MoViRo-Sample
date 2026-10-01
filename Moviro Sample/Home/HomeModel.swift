//
//  HomeModel.swift
//  Moviro Sample
//

import Moviro

// MARK: - Model

/// Typed to `HomeRouterInterface` rather than to `HomeRouter`: the model sees
/// only the navigation it is allowed to ask for.
@Observable
final class HomeModel: Model<any HomeRouterInterface> {

    // MARK: State

    private(set) var favoriteColor: SampleColor?
    private(set) var nickname = ""
    private(set) var appearCount = 0

    var hasChoices: Bool { favoriteColor != nil || !nickname.isEmpty }

    // MARK: Life cycle

    override func onAppear() {
        super.onAppear()
        appearCount += 1
    }

    // MARK: Actions

    func showDetail() {
        router?.showDetail()
    }

    func showPushSwitch() {
        router?.showPushSwitch()
    }

    func showSheet() {
        router?.showSheet()
    }

    func showFullScreen() {
        router?.showFullScreen()
    }

    func showModalSwitch() {
        router?.showModalSwitch()
    }

    func pickColor() {
        router?.showColorPicker { [weak self] color in
            // `nil` is Cancel: keep the color there was.
            guard let color else { return }
            self?.favoriteColor = color
        }
    }

    func editNickname() {
        router?.showNicknameEditor(nickname: nickname) { [weak self] nickname in
            guard let nickname else { return }
            self?.nickname = nickname
        }
    }

    func resetChoices() {
        router?.showAlert(config: .resetChoices { [weak self] in
            self?.performReset()
        })
    }

    private func performReset() {
        favoriteColor = nil
        nickname = ""
    }
}

// MARK: - Alert Configs

private extension AlertRouter.Config {

    static func resetChoices(onConfirm: @MainActor @escaping () -> Void) -> Self {
        .init(
            title: "Reset Choices?",
            message: "The favorite color and the nickname go back to not set.",
            actions: [
                .init(title: "Reset", role: .destructive, handler: onConfirm),
                .init(title: "Cancel", role: .cancel)
            ]
        )
    }
}
