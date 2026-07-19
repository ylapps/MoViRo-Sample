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

### Switch Routers
- **SampleModalSwitchRouter** -- swaps between two modal content screens without dismissing
- **SamplePushSwitchRouter** -- swaps between two pushed screens in-place

## Project Structure

```
Moviro Sample/
├── Moviro_SampleApp.swift    # App entry point
├── SampleAppRouter.swift     # Root router + SampleRootView
├── Detail/                   # Push navigation example
├── Home/                     # Home screen (push & modal triggers)
├── Modals/                   # Sheet, FullScreen, Popover examples
└── Switch/                   # Modal & Push switch examples
```

## License

This sample app is released under the [MIT License](LICENSE).
