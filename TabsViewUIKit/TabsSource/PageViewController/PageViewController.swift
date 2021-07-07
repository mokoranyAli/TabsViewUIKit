//
//  PageViewController.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/26/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit

// MARK: - PageViewController
//
class PageViewController: UIViewController {
    
    typealias Direction = UIPageViewController.NavigationDirection
    
    // MARK: - Views
    
    /// Tabs View that hold tabs
    ///
    let tabsView: TabView = {
        let view = TabView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionView.backgroundColor = .tab
        return view
    }()
    
    /// Page controller that hold tabs view controllers
    ///
    let pageController: UIPageViewController = {
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    // MARK: - Properties
    
    /// Selected index of tab view
    ///
    private(set) var selectedIndex: Int = .zero {
        didSet { updateSelectedController(oldIndex: oldValue) }
    }
    
    /// View Controllers List
    ///
    var controllers: [UIViewController] = [] {
        didSet { updateControllersAndTabsIfPossible() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureTabView()
        configurePageViewSwipe()
        updateControllersAndTabsIfPossible()
        
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        
        switch sender.direction {
        case .left:
            swipeRightIfPossible()
        case .right:
            swipeLeftIfPossible()
        default: break
        }
        
    }
}

// MARK: - Configurations
//
private extension PageViewController {
    
    /// Configure views
    ///
    func configureViews() {
        let stackView = UIStackView(arrangedSubviews: [tabsView, pageController.view])
        stackView.axis = .vertical
        addChild(pageController)
        view.addSubviewWithReleativeToGuides(stackView)
        
        NSLayoutConstraint.activate([
            tabsView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    /// Configure `TabView` on select Tab and list
    ///
    func configureTabView() {
        tabsView.configureOnSelect { [weak self] index in
            self?.selectedIndex = index
        }
    }
    
    func configurePageViewSwipe() {
        pageController.view.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        pageController.view.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
}

// MARK: - Private Handlers
//
private extension PageViewController {
    
    /// Update controllers and tabs. Will be implemented only when view is loaded.
    ///
    func updateControllersAndTabsIfPossible() {
        if isViewLoaded {
            controllers.forEach { $0.didMove(toParent: self) }
            updateSelectedController(oldIndex: selectedIndex, animated: false)
            updateVisibleTabs()
        }
    }
    
    /// Update view when needed with main tabs and selected tab
    ///
    func updateVisibleTabs() {
        tabsView.setList(controllers.map { $0.tabBarItem })
        tabsView.selectItem(at: selectedIndex)
    }
    
    /// Set view controllers that used for tabs
    ///
    func updateSelectedController(oldIndex: Int, animated: Bool = true) {
        let direction: Direction = oldIndex < selectedIndex ? .forward : .reverse
        selectViewController(direction: direction, animated: animated)
    }
    
    func selectViewController(direction: Direction, animated: Bool) {
        pageController.setViewControllers(
            [controllers[selectedIndex]], direction: direction, animated: animated
        )
    }
    
    /// Create swipe gestures to handle swipe left and right
    
    func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        // Initialize Swipe Gesture Recognizer
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        
        // Configure Swipe Gesture Recognizer
        swipeGestureRecognizer.direction = direction
        
        return swipeGestureRecognizer
    }
    
    func swipeRightIfPossible() {
        if selectedIndex < controllers.count - 1 {
            tabsView.selectItem(at: selectedIndex + 1)
        }
    }
    
    func swipeLeftIfPossible() {
        
        if selectedIndex > 0 {
            tabsView.selectItem(at: selectedIndex - 1)
        }
    }
}

// MARK: - Default Style
//
extension PageViewController {
    
    /// Apply default style
    ///
    func applyDefaultStyle() {
        tabsView.tintColor = .selected
    }
}
