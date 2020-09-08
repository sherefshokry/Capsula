//
//  UIImage.swift
//  Duzr
//
//  Created by George Naiem on 3/3/17.
//  Copyright © 2017 Duzr. All rights reserved.
//

import UIKit
import SDWebImage
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect.init(x:0, y:size.height - lineWidth, width:size.width, height:lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard (image?.cgImage) != nil else { return nil }
        self.init(cgImage: (image?.cgImage)!)
    }
    func maskWithColor(_ color: UIColor) -> UIImage? {
        let maskImage = self.cgImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        bitmapContext!.clip(to: bounds, mask: maskImage!)
        bitmapContext!.setFillColor(color.cgColor)
        bitmapContext!.fill(bounds)
        //is it nil?
        if let cImage = bitmapContext!.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            return coloredImage
        } else {
            return nil
        } 
    }
    static func compress (_ image : UIImage) -> UIImage {
        let actualHeight : CGFloat = image.size.height;
        let actualWidth : CGFloat = image.size.width;
        let maxHeight : CGFloat = 800.0;
        var maxWidth :CGFloat = maxHeight*actualWidth;
        maxWidth = maxWidth/actualHeight;
        let rect = CGRect.init(x:0.0, y:0.0, width:maxHeight, height:maxHeight);
        
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1.0)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img!
    }
    
    func toBase64() -> String? {
          guard let imageData = self.pngData() else { return nil }
          return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
      }
    
    
    func isEqualToImage(_ image: UIImage) -> Bool {
           let data1 = self.pngData()
           let data2 = image.pngData()
           return data1 == data2
       }
    
}
