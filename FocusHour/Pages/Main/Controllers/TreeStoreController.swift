//
//  ForestStoreController.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/6/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class TreeStoreController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var treeStoreView: TreeStoreView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action: #selector(TreeStoreController.fadeAway))
        backgroundView.addGestureRecognizer(gesture)
        backgroundView.isUserInteractionEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        treeStoreView.center.y -= view.bounds.height * 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            self.treeStoreView.center.y += self.view.bounds.height * 0.5
        }, completion: nil)
    }
    
    @objc func fadeAway() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.treeStoreView.center.y += self.view.bounds.height * 0.5
        }, completion: {(_) in
            self.view.removeFromSuperview()
        })
    }
}

extension TreeStoreController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themeCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightRatio = CGFloat(UIDevice().model == "iPad" ? 1.0 / 6.0 : 1.0 / 4.0)
        return heightRatio * UIScreen.main.bounds.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath) as! ThemeCell
        cell.theme = themeCells[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let theme = themeCells[indexPath.row]
        Theme.selectTheme(selectedTheme: theme)
        handleThemeChange(newTheme: theme)
    }
    
}

