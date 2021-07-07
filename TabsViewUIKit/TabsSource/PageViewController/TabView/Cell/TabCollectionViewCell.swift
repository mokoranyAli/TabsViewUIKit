//
//  TabCollectionViewCell.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/26/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit

// MARK: - TabCollectionViewCell
//
class TabCollectionViewCell: UICollectionViewCell {
    
  // MARK: - IBOutlets
  
  @IBOutlet private weak var button: UIButton!
  @IBOutlet private weak var lineView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.undoManager
    
    updateView()
  }
  
  // MARK: - Interface Properties
   
  /// Color indicates Tab title and footer color
  ///
  var selectedColor: UIColor? = .selected {
    didSet { updateView() }
  }

  /// Color indicates Tab title color
  ///
    var normalColor: UIColor? = .label {
    didSet { updateView() }
  }

  // MARK: - Override Properties
  
  override var isSelected: Bool {
    get {
      return super.isSelected
    }
    set {
      super.isSelected = newValue
      updateViewAnimated()
    }
  }
  
  // MARK: - Override Touches
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    showOnPressAnimation()
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    showOnPressAnimation()
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    hideOnPressAnimations()
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    hideOnPressAnimations()
  }
}

// MARK: - Handlers
//
private extension TabCollectionViewCell {
  
  /// Update view with animation; Mostly upon selection
  ///
  func updateViewAnimated() {
    UIView.animate(withDuration: 0.3) {
      self.updateView()
    }
  }
  
  /// Update view
  ///
  func updateView() {
    button.setTitleColor(isSelected ? selectedColor : normalColor, for: .normal)
    lineView.backgroundColor = isSelected ? selectedColor : .clear
    iconImageView.tintColor = isSelected ? selectedColor : normalColor
  }
}

// MARK: - Computed Properties
//
extension TabCollectionViewCell {
  
  /// Title label which indicates Tab title
  ///
  var title: String? {
    get { button.titleLabel?.text }
    set { button.setTitle(newValue, for: .normal) }
  }
  
  /// Icon Image
  ///
  var icon: UIImage? {
    get { iconImageView.image }
    set { iconImageView.image = newValue
        iconImageView.isHidden = newValue == nil
    }
  }
}

// MARK: - Touches Handlers
//
private extension TabCollectionViewCell {

  /// Show animations when touches starts
  ///
  func showOnPressAnimation() {
    UIView.animate(withDuration: 0.3) {
      self.button.transform = CGAffineTransform(scaleX: 0.9,y: 0.9)
    }
  }
  
  /// Hide animations when touches ends/ cancelled
  ///
  func hideOnPressAnimations() {
    UIView.animate(withDuration: 0.3) {
      self.button.transform = CGAffineTransform.identity
    }
  }
}
