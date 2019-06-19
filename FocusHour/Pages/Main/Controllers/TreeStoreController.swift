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
    
    var treeSeriesList = TreeSeries.getTreeSeriesList()
    var setTimeVC: SetTimeVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        treeStoreView.dataSource = self
        treeStoreView.delegate = self
        
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

extension TreeStoreController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treeSeriesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreeStoreCell", for: indexPath) as! TreeStoreCell
        cell.treeSeries = treeSeriesList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = treeSeriesList[indexPath.row]
        if selected.state != TreeSeriesState.OnSale.rawValue {
            TreeSeries.selectTreeSeries(selected)
            treeSeriesList = TreeSeries.getTreeSeriesList()
            tableView.reloadData()
            setTimeVC.refresh()
        } else {
            buyTreeSeries(treeSeries: selected)
        }
    }
    
}

extension TreeStoreController {
    
    func showMessageAlert(title: String, actionTitle: String, actionStyle: UIAlertAction.Style) {
        let alert = UIAlertController(
            title: title, message: "", preferredStyle: .alert
        )
        alert.addAction(.init(title: actionTitle, style: actionStyle))
        present(alert, animated: true, completion: nil)
    }
    
    func buyTreeSeries(treeSeries: TreeSeries) {
        let title = LocalizationKey.PurchasePrompt.translate()
        let message = "\(LocalizationKey.Price.translate()): \(treeSeries.price)\(LocalizationKey.Coins.translate())"
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert
        )
        alert.addAction(.init(title: LocalizationKey.Cancel.translate(), style: .cancel))
        let action = UIAlertAction(
            title: LocalizationKey.Yes.translate(),
            style: .default,
            handler: { (_) in
                let success = PreferenceTool.deductCoins(deductNumber: treeSeries.price)
                if success {
                    TreeSeries.selectTreeSeries(treeSeries)
                    self.showMessageAlert(title: LocalizationKey.PurchaseSuccess.translate(), actionTitle: LocalizationKey.Yes.translate(), actionStyle: .default)
                    self.treeSeriesList = TreeSeries.getTreeSeriesList()
                    self.treeStoreView.reloadData()
                    self.setTimeVC.refresh()
                } else {
                    self.showMessageAlert(title: LocalizationKey.InsufficientCoins.translate(), actionTitle: LocalizationKey.Cancel.translate(), actionStyle: .cancel)
                }
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

