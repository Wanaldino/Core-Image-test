print("Hello, world!")

import CoreImage
import ConsoleKit

let terminal = Terminal()

func printColors(of image: CGImage) {
    let context = CGContext(
        data: nil,
        width: image.width,
        height: image.height,
        bitsPerComponent: image.bitsPerComponent,
        bytesPerRow: image.width * image.bitsPerPixel / 8, //image.bytesPerRow could be different depending on image.byteOrderInfo, so you should be careful on it.
        space: image.colorSpace!,
        bitmapInfo: image.bitmapInfo.rawValue
    )!
    
    let imageSize = CGRect(origin: .zero, size: context.size)
    context.draw(image, in: imageSize)
    context.makeImage()?.saveAsJPEGFile()
    
    var intensities = context.data!.assumingMemoryBound(to: UInt32.self)
    var colors = [[ConsoleColor]]()
    for _ in 0 ..< context.height {
        var rowColors = [ConsoleColor]()
        for _ in 0 ..< context.width {
            rowColors.append(ConsoleColor.init(with: intensities.pointee))
            intensities += 1
        }
        colors.append(rowColors)
    }
    
    colors.forEach { (row) in
        row.forEach { (color) in
            terminal.output("M\t", style: .init(color: color), newLine: false)
        }
        terminal.output("")
    }
}


func main() {
    guard
        let url = URL(string: TestImages.googleLogo.rawValue),
        let ciImage = CIImage(contentsOf: url),
        let filter = CIFilter(name: "CIColorInvert")
    else { fatalError("Error while creating the ciImage") }
    
    filter.setDefaults()
    filter.setValue(ciImage, forKey: kCIInputImageKey)
    
    guard
        let ciImageNegative = filter.outputImage,
        let cgImage = ciImageNegative.cgImage,
        let cgImageReduced = cgImage.reduce(to: .init(width: 20, height: 20))
    else { fatalError("Cannot reduce the image") }
    
    printColors(of: cgImageReduced)
}

main()

