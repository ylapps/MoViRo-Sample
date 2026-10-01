# Moviro Sample

A sample iOS app demonstrating the [Moviro](https://github.com/ylapps/MoViRo) (Model-View-Router) architecture.

## Requirements

- iOS 17+ (the app also builds for visionOS)
- Xcode 26+ — the project uses Swift's default main-actor isolation, which earlier Xcode versions don't have
- Moviro 1.3.1+

## Getting Started

1. Clone this repository
2. Open `Moviro Sample.xcodeproj` in Xcode
3. Wait for Swift Package Manager to resolve the Moviro dependency
4. Build and run on a simulator or device

## What's Inside

Every screen is a Router / Model / View triad. The view forwards each action to
its model, and the model asks its router for navigation through a `…Routable`
protocol — Home and Detail models see their router only through an interface
protocol, never the concrete class.

### Push Navigation
- **HomeView** — root screen; every other screen is reached from here
- **DetailView** — pushed screen; presents each modal transition and pops itself with `close()` from `ClosableRouter`

### Modal Presentation
- **SheetView** — presented as a `.sheet`
- **FullScreenView** — presented as `.fullScreen`
- **PopoverView** — presented as `.popover` from Detail (iPhone shows it as a sheet)

### Close Reasons
- **ColorPickerView** — `ModalRouterWithCloseReason`: picking a color closes the sheet with it, Cancel closes it with `nil`
- **NicknameView** — `PushRouterWithCloseReason`: Save pops the screen with the new nickname; Back pops it without calling the handler

### Alerts
- **Reset Choices** on Home — a confirmation presented through `AlertRoutable`

### Switch Routers
- **SampleModalSwitchRouter** — swaps between two modal content screens without dismissing
- **SamplePushSwitchRouter** — swaps between two pushed screens in place

### Lifecycle
- Home counts its `onAppear` calls: popping a pushed screen counts, dismissing a modal over Home does not

### Previews
- Modal screens preview through `ModalPreviewRouter`, pushed screens inside a `NavigationStackRouter`

## Project Structure

```
Moviro Sample/
├── Moviro_SampleApp.swift    # App entry point
├── SampleRootView.swift      # Root view holding the home NavigationStackRouter
├── Home/                     # Home screen: starts every demo
├── Detail/                   # Push navigation, ClosableRouter
├── Modals/                   # Sheet, FullScreen, Popover
├── CloseReasons/             # Color picker (modal) and nickname editor (push)
└── Switch/                   # Modal & Push switch routers
```

## License

This sample app is released under the [MIT License](LICENSE).
