//
//  MenuViewController.swift
//  SlideOutMenu
//
//  Created by Yoram Soussan on 09/10/2018.
//  Copyright © 2018 Yoram Soussan. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
     var expandedSectionHeaderNumber: Int = -1
     var expandedSectionHeader: UITableViewHeaderFooterView!
     let kHeaderSectionTag: Int = 6900

    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    var sectionItems = [[String]]()
    var sectionsExpanded = [Int]()

    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionItems = [ ["iPhone 5", "iPhone 5s", "iPhone 6", "iPhone 6 Plus", "iPhone 7", "iPhone 7 Plus"],
                         ["iPad Mini", "iPad Air 2", "iPad Pro", "iPad Pro 9.7"],
                         ["Apple Watch", "Apple Watch 2", "Apple Watch 2 (Nike)"]
        ];
        tblMenuOptions.tableFooterView = UIView()
        
        tblMenuOptions.register(UINib(nibName: "MyCellTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCellTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"iPhone", "icon":"BT_iphone"])
        arrayMenuOptions.append(["title":"iPad", "icon":"BT_ipad"])
        
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParent()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellTableViewCell", for: indexPath) as! MyCellTableViewCell
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
       
        
        cell.titleLbl.text = sectionItems[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = storyboard!.instantiateViewController(withIdentifier: indexPath.section == 0 ? "iPhoneVC" : "iPadVC")
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsExpanded.contains(section) ? sectionItems[section].count : 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = customHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        header.titleLbl.text = arrayMenuOptions[section]["title"]
        
        header.imageHeader.image = UIImage(named: arrayMenuOptions[section]["icon"]!)
        header.isExpanded = sectionsExpanded.contains(section)
        
        header.delegate = self
        header.section = section
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayMenuOptions.count
    }
}

extension MenuViewController: customHeaderViewDelegate {
    func didDropDown(_ header: customHeaderView, at section: Int) {
        if sectionsExpanded.contains(section) {
            sectionsExpanded.remove(at: sectionsExpanded.firstIndex(of: section)!)
        } else {
            sectionsExpanded.append(section)
        }
        tblMenuOptions.reloadSections([section], with: .automatic)
    }
}
