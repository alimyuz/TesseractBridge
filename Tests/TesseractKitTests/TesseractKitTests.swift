import Testing
import Foundation
@testable import TesseractKit
import CLeptonica
import CTesseract

@Test func recognize() async throws {
    guard let api = TessBaseAPICreate() else {
        throw NSError(domain: "Tesseract", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create Tesseract API instance"])
    }
    defer { TessBaseAPIDelete(api) }

    let res = TessBaseAPIInit3(api, "/opt/homebrew/share/tessdata", "eng")
    #expect(res == 0)

    guard let filePath = Bundle.module.path(forResource: "hello_world", ofType: "png")?.cString(using: .utf8) else {
        throw NSError(domain: "Tesseract", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to get file path"])
    }

    let pix = try #require(pixRead(filePath))
    TessBaseAPISetImage2(api, pix)

    #expect(TessBaseAPIRecognize(api, nil) == 0)

    guard let textPointer = TessBaseAPIGetUTF8Text(api) else {
        throw NSError(domain: "Tesseract", code: 3, userInfo: [NSLocalizedDescriptionKey: "Failed to extract text"])
    }
    defer { TessDeleteText(textPointer) }

    let text = String(cString: textPointer)
    #expect(text == "print ( \"Hello, World!\" )\n")
}
