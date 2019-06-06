//
//  AchievementVC.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/16.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementVC: UIViewController {

    @IBOutlet weak var yearSelector: YearSelector!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedYear: Int!
    var cellInfoList: [(Int, String, Bool)] = []  // tuple中的三个成员是“month、text、InteractionEnabled”
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        yearSelector.achievementVC = self
        titleButton.addTarget(self, action: #selector(AchievementVC.displayYearSelector), for: .touchUpInside)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        setCollectionLayout()
        
        PlantRecord.generateRandomRecords()
        
        refreshAchievements(of: yearSelector.years.first ?? TimeTool.getCurrentYear())
    }
    
    private func setCollectionLayout() {
        // 在给layout设置itemSize的时候，需要使用view.frame.size，而不是collectionView.frame.size
        // 虽然在storyboard中，collectionView被view完全包住（前者到后者safearea的top、leading、bottom、trailing space都是0）
        // 但是如果在interface builder中选择view as iPhoneX，但是程序在iPhone8上运行的时候：
        // collectionView.frame.sizew.width = 414（对应iPX的宽度）；而不是iP8的宽度375
        // 但是最外层的view的宽度就是准确的...
        let cellNumPerLine: CGFloat = UIDevice().model == "iPad" ? 3 : 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space: CGFloat = 32
        let width = (view.frame.size.width - space * (cellNumPerLine + 1)) / cellNumPerLine
        let height = width * AchievementCell.ratio
        layout.itemSize = CGSize(width: Int(width), height: Int(height))  // 最后设置宽和高的时候要取整抹零，不然零点几的宽度差会把cell挤到下一行
    }
    
    private func refreshAchievements(of year: Int) {
        selectedYear = year
        titleButton.setTitle("\(year)", for: .normal)
        cellInfoList.removeAll()
        for month in MonthKey.getKeyList() {
            let monthNumber = month.getNumber()
            let minutes = PlantRecord.loadTotalTime(year: year, month: monthNumber)
            let text = "\(month.translate()) \(TimeTool.minuteFormat(of: minutes))"
            let interactionEnabled = minutes > 0
            cellInfoList.append((monthNumber, text, interactionEnabled))
        }
        collectionView.reloadData()
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func displayYearSelector() {
        yearSelector.isButtonsHidden = !yearSelector.isButtonsHidden
        collectionView.isUserInteractionEnabled = yearSelector.isButtonsHidden
    }
    
    @objc func showAchievements(ofyear year: Int) {
        displayYearSelector()
        refreshAchievements(of: year)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case SegueKey.ShowAchievementDetails.rawValue:
            guard let detailVC = segue.destination as? AchievementDetailVC else { return }
            let selectedCell = sender as! AchievementCell
            detailVC.year = selectedYear
            detailVC.month = selectedCell.month
        default:
            return
        }
    }
}

extension AchievementVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCell", for: indexPath) as! AchievementCell
        cell.month = cellInfoList[indexPath.row].0
        cell.drawCell(icon: UIImage(named: "trophy"), text: cellInfoList[indexPath.row].1)
        cell.isUserInteractionEnabled = cellInfoList[indexPath.row].2
        return cell
    }

}
