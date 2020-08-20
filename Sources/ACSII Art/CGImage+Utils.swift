//
//  File.swift
//  
//
//  Created by Wanaldino Antimonio on 09/06/2020.
//

import CoreImage

extension CGImage {
    var size: CGSize {
        return CGSize(
            width: width,
            height: height
        )
    }
    
    var ciImage: CIImage {
        return CIImage(cgImage: self)
    }
    
    var context: CGContext? {
        guard let colorSpace = colorSpace else { return nil }
        return CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        )
    }
    
    func reduce(to size: CGSize) -> CGImage? {
        guard let colorSpace = colorSpace else { return nil }
        guard let context = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else { return nil }
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.draw(self, in: imageRect)
        return context.makeImage()
    }
    
    func saveAsJPEGFile() {
        let desktop = try! FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("file").appendingPathExtension("jpeg")
        
        let ciContext = CIContext(cgContext: self.context!, options: nil)
        try! ciContext.writeJPEGRepresentation(of: ciImage, to: desktop, colorSpace: colorSpace!, options: [:])
    }
}
