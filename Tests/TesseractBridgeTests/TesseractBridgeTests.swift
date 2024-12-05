import Testing
import Foundation
import CLeptonica
import CTesseract

@Test func recognize() async throws {
    let api = try #require(TessBaseAPICreate())
    defer { TessBaseAPIDelete(api) }
    
    let res = TessBaseAPIInit3(api, "/opt/homebrew/share/tessdata", "eng")
    #expect(res == 0)
    
    let filePath = try #require(Bundle.module.path(forResource: "hello_world", ofType: "png")?
        .cString(using: .utf8))
    
    let pix = try #require(pixRead(filePath))
    TessBaseAPISetImage2(api, pix)
    
    #expect(TessBaseAPIRecognize(api, nil) == 0)
    
    let textPointer = try #require(TessBaseAPIGetUTF8Text(api))
    defer { TessDeleteText(textPointer) }
    
    let text = String(cString: textPointer)
    #expect(text == "print ( \"Hello, World!\" )\n")
}
