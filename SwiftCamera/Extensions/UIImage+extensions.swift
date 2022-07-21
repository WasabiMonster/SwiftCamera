//
//  UIImage+extensions.swift
//  Backflip
//
//  Created by Patrick Wilson on 4/20/22.
//

import UIKit
import CoreGraphics

private let inputImageKey = "inputImage"

extension UIImage {
	static func qrCode(
		data: Data,
		color: CIColor = .black,
		backgroundColor: CIColor = .white
	) -> UIImage? {
		guard let qrFilter = CIFilter(name: "CIQRCodeGenerator"),
			  let colorFilter = CIFilter(name: "CIFalseColor") else { return nil }

		qrFilter.setDefaults()
		qrFilter.setValue(data, forKey: "inputMessage")
		qrFilter.setValue("L", forKey: "inputCorrectionLevel")

		colorFilter.setDefaults()
		colorFilter.setValue(qrFilter.outputImage, forKey: "inputImage")
		colorFilter.setValue(color, forKey: "inputColor0")
		colorFilter.setValue(backgroundColor, forKey: "inputColor1")

		guard let outputImage = colorFilter.outputImage else { return nil }
		guard let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) else { return nil }
		return UIImage(cgImage: cgImage)
	}

	func resize(_ size: CGSize) -> UIImage {
		let image = UIGraphicsImageRenderer(size: size).image { _ in
			draw(in: CGRect(origin: .zero, size: size))
		}

		return image.withRenderingMode(renderingMode)
	}

	/* func resize(_ size: CGSize, inset: CGFloat = 6.0) -> UIImage? {
		UIGraphicsImageRenderer(size: size)
		defer { UIGraphicsEndImageContext() }

		guard let context = UIGraphicsGetCurrentContext() else {
			// was crashing at times before
			// assert(false, "Could not create image context"); return nil
			log.error("Could not create image context. Resize not possible.")
			return self
		}
		guard let cgImage = self.cgImage else {
			// assert(false, "No cgImage property")
			log.error("No cgImage property. Resize not possible.")
			return self
		}

		context.interpolationQuality = .none
		context.rotate(by: π) // flip
		context.scaleBy(x: -1.0, y: 1.0) // mirror
		context.draw(cgImage, in: context.boundingBoxOfClipPath.insetBy(dx: inset, dy: inset))
		print("*052222* \(type(of: self)), \(#function) |> Resize \(size.width), \(size.height)")

		return UIGraphicsGetImageFromCurrentImageContext()
	} */

	static func imageForColor(_ color: UIColor) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		context?.setFillColor(color.cgColor)
		context?.fill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image ?? UIImage()
	}

	func image(withInsets insets: UIEdgeInsets) -> UIImage? {
		let width = self.size.width + insets.left + insets.right
		let height = self.size.height + insets.top + insets.bottom
		UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, self.scale)
		let origin = CGPoint(x: insets.left, y: insets.top)
		self.draw(at: origin)
		let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return imageWithInsets?.withRenderingMode(renderingMode)
	}

	func tinted(with color: UIColor) -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		defer { UIGraphicsEndImageContext() }
		color.set()
		withRenderingMode(.alwaysTemplate)
			.draw(in: CGRect(origin: .zero, size: size))
		return UIGraphicsGetImageFromCurrentImageContext()
	}

	static func fetchAsync(from imageUrl: String, callback: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: imageUrl) else {
			callback(nil)
			return
		}

		DispatchQueue.global(qos: .userInitiated).async {
			let data = try? Data(contentsOf: url)

			if let imageData = data, let image = UIImage(data: imageData) {
				DispatchQueue.main.async {
					callback(image)
				}
			} else {
				DispatchQueue.main.async {
					callback(nil)
				}
			}
		}
	}
}

extension UIImage {
    func trim() -> UIImage {
        let newRect = self.cropRect
        if let imageRef = self.cgImage!.cropping(to: newRect) {
            return UIImage(cgImage: imageRef)
        }
        return self
    }

    var cropRect: CGRect {
        let cgImage = self.cgImage
        let context = createARGBBitmapContextFromImage(inImage: cgImage!)
        if context == nil {
            return CGRect.zero
        }

        let height = CGFloat(cgImage!.height)
        let width = CGFloat(cgImage!.width)

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context?.draw(cgImage!, in: rect)

        //let data = UnsafePointer<CUnsignedChar>(CGBitmapContextGetData(context))
        guard let data = context?.data?.assumingMemoryBound(to: UInt8.self) else {
            return CGRect.zero
        }

        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0

        let heightInt = Int(height)
        let widthInt = Int(width)
        //Filter through data and look for non-transparent pixels.
        for y in (0 ..< heightInt) {
            let y = CGFloat(y)
            for x in (0 ..< widthInt) {
                let x = CGFloat(x)
                let pixelIndex = (width * y + x) * 4 /* 4 for A, R, G, B */

                if data[Int(pixelIndex)] == 0  { continue } // crop transparent

                if data[Int(pixelIndex+1)] > 0xE0 && data[Int(pixelIndex+2)] > 0xE0 && data[Int(pixelIndex+3)] > 0xE0 { continue } // crop white

                if (x < lowX) {
                    lowX = x
                }
                if (x > highX) {
                    highX = x
                }
                if (y < lowY) {
                    lowY = y
                }
                if (y > highY) {
                    highY = y
                }
            }
        }

        return CGRect(x: lowX, y: lowY, width: highX - lowX, height: highY - lowY)
    }

    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {

        let width = inImage.width
        let height = inImage.height

        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }

        let context = CGContext (data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8,      // bits per component
            bytesPerRow: bitmapBytesPerRow,
            space: colorSpace,
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)

        return context
    }
}
