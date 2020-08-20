//
//  File.swift
//  
//
//  Created by Wanaldino Antimonio on 09/06/2020.
//

import CoreImage

extension CIImage {
    var cgImage: CGImage? {
        let context = CIContext()
        return context.createCGImage(self, from: extent)
    }
}
