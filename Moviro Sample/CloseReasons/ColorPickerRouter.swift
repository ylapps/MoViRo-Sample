//
//  ColorPickerRouter.swift
//  Moviro Sample
//

import Moviro

// MARK: - Routable

@MainActor
protocol ColorPickerRoutable {
    func showColorPicker(onClose: @escaping (SampleColor?) -> Void)
}

extension ColorPickerRoutable where Self: AnyPushRouter {
    func showColorPicker(onClose: @escaping (SampleColor?) -> Void) {
        presented = ColorPickerRouter(onWillCloseWithReason: onClose)
    }
}

// MARK: - Close Reason

/// What the color picker closes with.
enum SampleColor: String, CaseIterable, Identifiable {
    case red, orange, green, blue, purple

    var id: Self { self }

    var title: String { rawValue.capitalized }

    var color: Color {
        switch self {
        case .red: .red
        case .orange: .orange
        case .green: .green
        case .blue: .blue
        case .purple: .purple
        }
    }
}

// MARK: - Model

@Observable
final class ColorPickerModel: Model<ColorPickerRouter> {

    let colors = SampleColor.allCases

    func pick(_ color: SampleColor) {
        router?.requestClose(with: color)
    }

    /// Closes without a reason: the caller's handler receives `nil`.
    func cancel() {
        router?.requestClose()
    }
}

// MARK: - Router

/// A sheet that closes with a reason. `requestClose(with:)` hands the reason to
/// the caller's `onWillCloseWithReason` first, then dismisses the sheet.
final class ColorPickerRouter: ModalRouterWithCloseReason<ColorPickerView, SampleColor> {

    init(onWillCloseWithReason: ReasonHandler?) {
        super.init(transition: .sheet, onWillCloseWithReason: onWillCloseWithReason)
    }

    override func makeModel() -> ColorPickerModel {
        ColorPickerModel(router: self)
    }
}
