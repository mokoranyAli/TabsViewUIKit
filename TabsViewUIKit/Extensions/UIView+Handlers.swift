//
//  UIView+Handlers.swift
//  TabsViewUIKit
//
//  Created by Mohamed Korany on 6/26/21.
//  Copyright © 2021 Mohamed Korany. All rights reserved.
//

import UIKit

extension UIView {
    func applyDefaultAppearance() {
        backgroundColor = .container
    }
    
    /// Add subview with relative to guides
    ///
    func addSubviewWithReleativeToGuides(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subview.topAnchor.constraint(equalTo: margins.topAnchor),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    /// Add and fix `UIView` on `ContainerView`. Giving the newly added view the same frame as the container.
    ///
    func addAndFixInView(_ container: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }
}


enum Human {
    case male
    case female
}
struct Male {
    func hateShopping() {
        // This is just kidding
        print("I love sleeping")
    }
}

struct Female {
    func loveShpopping() {
        // This is just kidding
        print("I love shopping")
    }
}

protocol HumanBehavior {
    associatedtype HumanType
    func actAsType()
    var human: HumanType { get }
}

struct MaleBehavior: HumanBehavior {
    let human: Male = Male()

    func actAsType() {
        human.hateShopping()
    }
}


struct FemaleBehavior: HumanBehavior {
    func actAsType() {
        human.loveShpopping()
    }
    
    var human: Female = Female()
    
    typealias HumanType = Female
}

class HumanBehaviorFactory {
    static func getBehavior(with type: Human) -> some HumanBehavior {
        
        if type == .female {
            return MaleBehavior()
        }
       
        return FemaleBehavior()
    }
}

//HumanBehaviorFactory.getBehavior(with: .female).actAsType() // print i love shopping
