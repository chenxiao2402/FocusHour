//
//  AchievementVC.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementVC: UIViewController {

    @IBOutlet weak var yearSelector: YearSelector!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let bugers = [
        "buger1", "buger2", "buger3", "buger4", "buger5", "buger6",
        "buger7", "buger8", "buger9", "buger10", "buger11", "buger12",
    ]
    
    let bugerImages = [
        UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"),
        UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"),
        UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"),
        UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree"), UIImage(named: "level0-baretree")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        yearSelector.achievementVC = self
        titleButton.setTitle("\(TimeTool.getCurrentYear())", for: .normal)
        titleButton.addTarget(self, action: #selector(AchievementVC.displayYearSelector), for: .touchUpInside)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func displayYearSelector() {
        yearSelector.isButtonsHidden = !yearSelector.isButtonsHidden
        collectionView.isUserInteractionEnabled = yearSelector.isButtonsHidden
    }
    
    @objc func showAchievement(ofyear year: Int) {
        titleButton.setTitle("\(year)", for: .normal)
        displayYearSelector()
    }

}

extension AchievementVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bugers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.hambugerLabel.text = bugers[indexPath.row]
        cell.hambugerImageView.image = bugerImages[indexPath.row]
        return cell
    }
}
