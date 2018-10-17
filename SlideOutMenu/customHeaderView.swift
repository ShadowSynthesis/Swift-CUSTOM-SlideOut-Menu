//
//  customHeaderView.swift
//  SlideOutMenu
//
//  Created by Yoram Soussan on 16/10/2018.
//  Copyright © 2018 Yoram Soussan. All rights reserved.
//

import UIKit

protocol customHeaderViewDelegate {
    func didDropDown(_ header: customHeaderView, at section: Int)
}

class customHeaderView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageHeader: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    var section = 0
    var delegate: customHeaderViewDelegate?
    var isExpanded = false {
        didSet {
            arrowImage.image = isExpanded ? UIImage(named: "ExpandMore")?.rotate(radians: .pi) : UIImage(named: "ExpandMore")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }

    private func setup() {
        Bundle.main.loadNibNamed("customHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dropDownAction))
        contentView.addGestureRecognizer(tap)
    }
    
    @objc private func dropDownAction() {
        delegate?.didDropDown(self, at: section)
    }
}
