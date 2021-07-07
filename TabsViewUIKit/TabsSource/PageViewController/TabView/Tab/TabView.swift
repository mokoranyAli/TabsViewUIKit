//
//  TabView.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/26/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit
import SwiftUI
// MARK: - TabView
//
class TabView: UIView {
  
  typealias ElementType = UIBarItem
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var contentView: UIView!
@AppStorage("username") var username: String = "Anonymous"

  
  // MARK: - Properties
  
  /// On select index return index of selected item
  ///
  private var onSelect: ((Int) -> Void)?
  
  /// Selected index indicates that index of current tab
  ///
  private var selectedIndex: Int? {
    didSet {
      if let newValue = selectedIndex {
        onSelect?(newValue)
      }
    }
  }
  
  /// List of tab items
  ///
  private var list: [ElementType] = [] {
    didSet {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    commitInit()
    configureCollectionView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    commitInit()
    configureCollectionView()
  }
}

// MARK: - Configure View
//
private extension TabView {
  
  /// Commit Init
  ///
  func commitInit() {
    Bundle.main.loadNibNamed(String(describing: TabView.self), owner: self, options: nil)
    contentView.addAndFixInView(self)
  }
  
  /// Configure Collection View
  ///
  func configureCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsSelection = true
    collectionView.contentInset = UIEdgeInsets(
      top: .zero, left: .zero, bottom: .zero, right: .zero
    )
    registerCells(in: collectionView)
  }
  
  func registerCells(in collectionView: UICollectionView) {
    let nibName = String(describing: TabCollectionViewCell.self)
    let nib = UINib(nibName: nibName, bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: nibName)
  }
}

// MARK: - Public Handlers
//
extension TabView {
  
  /// Set tab list items
  /// - Parameters:
  ///   - list: list of tab items titles as `String`
  ///   - selectedIndex: The initial selected index for initial view controller index
  ///
  func setList(_ list: [ElementType], selectedIndex: Int? = nil) {
    self.list = list
    if let index = selectedIndex {
      selectItem(at: index)
    }
  }
  
  /// Select index in index when switch between tabs
  /// - Parameters:
  ///   - index: Tab index
  ///   - animated: Sholud animate or not .. default is `true`
  ///
  func selectItem(at index: Int, animated: Bool = false) {
    self.selectedIndex = index
    let indexPath = IndexPath(row: index, section: .zero)
    DispatchQueue.main.async {
      self.collectionView.selectItem(
        at: indexPath, animated: animated, scrollPosition: .centeredHorizontally
      )
    }
  }
  
  /// On Select item in tabs
  /// - Parameter onSelect: Returns index of selected tab
  ///
  func configureOnSelect(onSelect: @escaping ((Int) -> Void)) {
    self.onSelect = onSelect
  }
}

// MARK: - UICollectionViewDataSource
//
extension TabView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return list.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = String(describing: TabCollectionViewCell.self)
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TabCollectionViewCell {
      configureTabCell(cell, at: indexPath)
      return cell
    }
    
    return UICollectionViewCell()
  }
}

// MARK: - UICollectionViewDataSource Cell Configuration
//
extension TabView {
  
  func configureTabCell(_ cell: TabCollectionViewCell, at indexPath: IndexPath) {
    let item = list[indexPath.row]
    cell.title = item.title
    cell.icon = item.image
    cell.selectedColor = tintColor
    cell.isSelected = indexPath.item == selectedIndex
  }
}

// MARK: - UICollectionViewDelegate
//
extension TabView: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.item
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
//
extension TabView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let height = collectionView.bounds.height
    let width = collectionView.bounds.width / CGFloat(list.count)
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .zero
  }
}

