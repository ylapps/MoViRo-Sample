# Moviro Sample

A sample iOS app demonstrating the [Moviro](https://github.com/ylapps/MoViRo) (Model-View-Router) architecture.

## Requirements

- iOS 17+
- Xcode 15+

## Getting Started

1. Clone this repository
2. Open `Moviro Sample.xcodeproj` in Xcode
3. Wait for Swift Package Manager to resolve the Moviro dependency
4. Build and run on a simulator or device

## What's Inside

The sample app showcases every navigation pattern provided by Moviro:

### Push Navigation
- **HomeView** -- root screen with buttons to push and present
- **DetailView** -- pushed screen demonstrating `requestClose()` to pop back

### Modal Presentation
- **SheetView** -- presented as a `.sheet`
- **FullScreenView** -- presented as `.fullScreen`
- **PopoverView** -- presented as `.popover`

### Tab Bar
- **SampleAppRouter** -- `AnyTabBarRouter` with Home and Split tabs

### Split View
- **SampleSplitRouter** -- `AnySplitRouter` with a sidebar and detail column
- **SidebarView** -- list of items that push details into the detail column

### Switch Routers
- **SampleModalSwitchRouter** -- swaps between two modal content screens without dismissing
- **SamplePushSwitchRouter** -- swaps between two pushed screens in-place

### Window Router
- **SampleWindowRouter** -- demonstrates `WindowRouter` for app-level overlays
- **WindowAlertRouter** -- alert displayed in a separate `UIWindow`
- **WindowToastRouter** -- auto-dismissing toast banner in its own `UIWindow`

## Project Structure

```
Moviro Sample/
├── Moviro_SampleApp.swift    # App entry point (uses SampleRootScene)
├── SampleAppRouter.swift     # TabBar root + SampleRootView/Scene
├── Detail/                   # Push navigation example
├── Home/                     # Home tab (push, modal, window triggers)
├── Modals/                   # Sheet, FullScreen, Popover examples
├── Split/                    # NavigationSplitView example
├── Switch/                   # Modal & Push switch examples
└── Window/                   # Window-level alerts & toasts
```

## License

This sample app is released under the [MIT License](LICENSE).
