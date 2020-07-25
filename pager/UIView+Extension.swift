//
//  UIView+Extension.swift
//  ShallWeShop
//
//  Created by Inpyo Hong on 2020/02/27.
//  Copyright © 2020 Epiens Corp. All rights reserved.
//

import UIKit

// MARK: - CALayer
extension UIView {
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }

  @IBInspectable var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }

  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }

  @IBInspectable var isCircular: Bool {
    get {
      let radius = self.frame.width/2
      return layer.cornerRadius == radius
    }
    set {
      if newValue {
        let radius = self.frame.width/2
        layer.cornerRadius = radius
      } else {
        layer.cornerRadius = 0
      }

      layer.masksToBounds = newValue
    }
  }
}

// MARK: - Reusable & Nib Loadable
protocol ReusableView: class {}

extension ReusableView where Self: UIView {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
  static var nibName: String {
    return String(describing: self)
  }
}

// MARK: - Generates instance of view from nib
extension UIView {
  class func instance(_ name: String? = nil, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> Self? {
    return instanceHelper(name ?? String(describing: self),
                          owner: owner,
                          options: options)
  }

  fileprivate class func instanceHelper<T>(_ name: String, owner: Any?, options: [UINib.OptionsKey: Any]? = nil) -> T? {
    guard let views = Bundle.main.loadNibNamed(name, owner: owner, options: options) else { return nil }
    return views.first as? T
  }
}

//// MARK: - Animation
//extension UIView {
//  func setHidden(_ hidden: Bool, animated: Bool) {
//    if isHidden == hidden { return }
//
//    alpha = hidden ? 1 : 0
//    isHidden = false
//
//    UIView.animate(
//      withDuration: animated ? Utils.Animations.duration : 0,
//      animations: { [weak self] in
//        guard let self = self else { return }
//        self.alpha = hidden ? 0 : 1
//      },
//      completion: { [weak self] _ in
//        guard let self = self else { return }
//        self.isHidden = hidden
//        self.alpha = 1
//      }
//    )
//  }
//
//  func blink() {
//    UIView.animate(withDuration: 1,
//                   delay: 0,
//                   options: [.curveEaseInOut, .repeat, .autoreverse],
//                   animations: { [unowned self] in self.alpha = 0 },
//                   completion: { [unowned self] _ in self.alpha = 1 })
//  }
//
//  func stopBlink() {
//    UIView.animate(withDuration: 0,
//                   delay: 0,
//                   options: [.curveEaseInOut, .beginFromCurrentState],
//                   animations: { [unowned self] in self.alpha = 1.0 })
//  }
//}
//
//extension UIView {
//  var responder: UIViewController? {
//    if let next = next as? UIViewController {
//      return next
//    } else if let next = next as? UIView {
//      return next.responder
//    } else {
//      return nil
//    }
//  }
//}

extension UIView {

  func constrainCentered(_ subview: UIView) {

    subview.translatesAutoresizingMaskIntoConstraints = false

    let verticalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerY,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerY,
      multiplier: 1.0,
      constant: 0)

    let horizontalContraint = NSLayoutConstraint(
      item: subview,
      attribute: .centerX,
      relatedBy: .equal,
      toItem: self,
      attribute: .centerX,
      multiplier: 1.0,
      constant: 0)

    let heightContraint = NSLayoutConstraint(
      item: subview,
      attribute: .height,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.height)

    let widthContraint = NSLayoutConstraint(
      item: subview,
      attribute: .width,
      relatedBy: .equal,
      toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1.0,
      constant: subview.frame.width)

    addConstraints([
      horizontalContraint,
      verticalContraint,
      heightContraint,
      widthContraint])

  }

  func constrainToEdges(_ subview: UIView) {

    subview.translatesAutoresizingMaskIntoConstraints = false

    let topContraint = NSLayoutConstraint(
      item: subview,
      attribute: .top,
      relatedBy: .equal,
      toItem: self,
      attribute: .top,
      multiplier: 1.0,
      constant: 0)

    let bottomConstraint = NSLayoutConstraint(
      item: subview,
      attribute: .bottom,
      relatedBy: .equal,
      toItem: self,
      attribute: .bottom,
      multiplier: 1.0,
      constant: 0)

    let leadingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .leading,
      relatedBy: .equal,
      toItem: self,
      attribute: .leading,
      multiplier: 1.0,
      constant: 0)

    let trailingContraint = NSLayoutConstraint(
      item: subview,
      attribute: .trailing,
      relatedBy: .equal,
      toItem: self,
      attribute: .trailing,
      multiplier: 1.0,
      constant: 0)

    addConstraints([
      topContraint,
      bottomConstraint,
      leadingContraint,
      trailingContraint])
  }

}
