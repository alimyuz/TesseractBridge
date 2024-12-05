# TesseractBridge

A simple bridge to the Tesseract OCR and Leptonica C++ libraries. **This is not an SDK** — it provides no high-level abstractions and requires direct interaction with the underlying APIs.

## Requirements

- Tesseract and Leptonica must be installed and available in `$PATH`.
- Tesseract data files (e.g., `/opt/homebrew/share/tessdata`).

## Installation

### Install Tesseract
```zsh
brew install tesseract

#install languages if needed
brew install tesseract-lang
```

### Add `TesseractBridge` to your `Package.swift`:

```swift
// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(url: "https://github.com/alimyuz/TesseractBridge.git", from: "0.0.1"),
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["TesseractBridge"]),
    ]
)
```

## Usage
```swift
import CLeptonica
import CTesseract

let api = try TessBaseAPICreate()
defer { TessBaseAPIDelete(api) }

try TessBaseAPIInit3(api, "/opt/homebrew/share/tessdata", "eng")

let filePath = try Bundle.module.path(forResource: "hello_world", ofType: "png")!
let pix = try pixRead(filePath.cString(using: .utf8)!)
TessBaseAPISetImage2(api, pix)

try TessBaseAPIRecognize(api, nil)
let text = String(cString: TessBaseAPIGetUTF8Text(api))
```

## Notes:
  -  Not an SDK: No additional abstractions are provided beyond the raw C++ APIs.
  -  Tesseract and Leptonica are not bundled and must be pre-installed.
