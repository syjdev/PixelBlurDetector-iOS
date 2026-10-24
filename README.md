# PixelBlurDetector for iOS

**Find the blurry regions of a photo, pixel by pixel, on iOS.**

`PixelBlurDetectorKit` runs a small segmentation model through Core ML (CPU, GPU or Neural Engine)
and returns a blur map with one value per pixel. The model is compiled into the package's resource
bundle, so nothing else has to be shipped.

This is the iOS SDK of [PixelBlurDetector](https://github.com/syjdev/PixelBlurDetector), which
has the overview, sample results and the demo apps. The Android SDK, which produces matching
results, is [PixelBlurDetector-Android](https://github.com/syjdev/PixelBlurDetector-Android).
Please open issues in the [main repository](https://github.com/syjdev/PixelBlurDetector/issues).

## Installation

Requires iOS 16.2+. In Xcode, choose **File › Add Package Dependencies…** and enter
`https://github.com/syjdev/PixelBlurDetector-iOS`, or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/syjdev/PixelBlurDetector-iOS.git", from: "3.0.0"),
],
targets: [
    .target(name: "YourApp", dependencies: [
        .product(name: "PixelBlurDetectorKit", package: "PixelBlurDetector-iOS"),
    ]),
]
```

## Usage

```swift
import PixelBlurDetectorKit

let detector = PixelBlurDetector()

// Optional: load the model ahead of the first prediction (e.g. when the screen appears).
try await detector.prepare()

// Pass the raw CGImage and how it should be displayed; the rotation is applied while sampling.
let image: UIImage = ...
let observation = try await detector.predict(input: image.cgImage!,
                                             orientation: CGImagePropertyOrientation(image.imageOrientation))

imageView.image = UIImage(cgImage: observation.blurMap)  // grayscale, brighter = blurrier
let isBlurry = observation.blurRatio() > 0.5             // fraction of pixels above 127

// Per-stage durations measured inside the SDK (Swift `Duration`s).
print(observation.timings.preprocessing, observation.timings.inference, observation.timings.postprocessing)
```

`CGImagePropertyOrientation(_: UIImage.Orientation)` is not part of the SDK; see the small
extension at the bottom of the demo's
[`ViewController.swift`](https://github.com/syjdev/PixelBlurDetector/blob/master/examples/ios/demo/ViewController.swift).

- `PixelBlurDetector` is an actor; share one instance. Predictions run one at a time on a
  dedicated queue, never on the caller's thread.
- Any image size or aspect ratio is accepted. The image is letterboxed to the model's 224×224 input
  and the blur map is cropped back to the image's aspect ratio (in its displayed orientation).
- Errors are thrown as `PixelBlurDetectorError` (`modelLoadFailed`, `imagePreprocessingFailed`,
  `inferenceFailed`, `unexpectedOutput`).

## Development

```
Package.swift
Sources/PixelBlurDetectorKit/       SDK sources and the Core ML model (BlurSegmentation.mlpackage)
Tests/PixelBlurDetectorKitTests/    unit tests, with CC0 test images in resources/
```

Run the tests:

```bash
xcodebuild test -scheme PixelBlurDetector-iOS \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

To try local changes in the demo app, see the
[examples README](https://github.com/syjdev/PixelBlurDetector/tree/master/examples#ios).

### Releasing

Swift Package Manager reads versions from git tags. Push a tag such as `3.0.0` on `main`; there is
nothing else to upload.

## License

- **Code**: Apache-2.0. See [`LICENSE`](LICENSE) and [`NOTICE`](NOTICE).
- **`BlurSegmentation.mlpackage`**: trained on the CUHK and DUT-DBD datasets, neither of which
  states a license, so it is **research / non-commercial only** for now. See
  [`MODEL_LICENSE.md`](MODEL_LICENSE.md).
- **Test images** (`cc0_*`): CC0 (public domain) from Wikimedia Commons:
  [Ant on sunflower with snail](https://commons.wikimedia.org/wiki/File:Ant_on_sunflower_with_snail.jpg),
  [Brightin Star 35mm f0.95 - Cherry Blossom](https://commons.wikimedia.org/wiki/File:Brightin_Star_35mm_f0.95_-_Cherry_Blossom.jpg),
  [Blurry misty river](https://commons.wikimedia.org/wiki/File:Blurry_misty_river.jpg).
