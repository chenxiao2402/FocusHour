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
        UIImage(named: "trophy"), UIImage(named: "trophy"), UIImage(named: "trophy"),
        UIImage(named: "trophy"), UIImage(named: "trophy"), UIImage(named: "trophy"),
        UIImage(named: "trophy"), UIImage(named: "trophy"), UIImage(named: "trophy"),
        UIImage(named: "trophy"), UIImage(named: "trophy"), UIImage(named: "trophy")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        yearSelector.achievementVC = self
        titleButton.setTitle("\(TimeTool.getCurrentYear())", for: .normal)
        titleButton.addTarget(self, action: #selector(AchievementVC.displayYearSelector), for: .touchUpInside)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
        setLayout()
    }
    
    private func setLayout() {
        // 在给layout设置itemSize的时候，需要使用view.frame.size，而不是collectionView.frame.size
        // 虽然在storyboard中，collectionView被view完全包住（前者到后者safearea的top、leading、bottom、trailing space都是0）
        // 但是如果在interface builder中选择view as iPhoneX，但是程序在iPhone8上运行的时候：
        // collectionView.frame.sizew.width = 414（对应iPX的宽度）；而不是iP8的宽度375
        // 但是最外层的view的宽度就是准确的...
        let cellNumPerLine: CGFloat = UIDevice().model == "iPad" ? 3 : 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space: CGFloat = 32
        let width = (view.frame.size.width - space * (cellNumPerLine + 1)) / cellNumPerLine
        let height = width * CollectionViewCell.ratio
        layout.itemSize = CGSize(width: Int(width), height: Int(height))  // 最后设置宽和高的时候要取整抹零，不然零点几的宽度差会把cell挤到下一行
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
//        cell.layer.borderColor = UIColor.gray.cgColor
//        cell.layer.borderWidth = 1
        cell.drawCell(icon: bugerImages[indexPath.row], text: bugers[indexPath.row])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.gray.cgColor
//        cell?.layer.borderWidth = 3
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        cell?.layer.borderColor = UIColor.gray.cgColor
//        cell?.layer.borderWidth = 1
//    }
}
