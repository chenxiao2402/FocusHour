//
//  AchievementDetailVC.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var year: Int!
    var month: Int!
    var recordList: [PlantRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        recordList = PlantRecord.loadRecords(year: year, month: month)
        setTitle()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        setCollectionLayout()
    }
    
    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont(name: "Verdana", size: 22.0)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        titleLabel.text = "\(year!).\(month!)"
        navigationItem.titleView = titleLabel
    }
    
    private func setCollectionLayout() {
        // 在给layout设置itemSize的时候，需要使用view.frame.size，而不是collectionView.frame.size
        // 虽然在storyboard中，collectionView被view完全包住（前者到后者safearea的top、leading、bottom、trailing space都是0）
        // 但是如果在interface builder中选择view as iPhoneX，但是程序在iPhone8上运行的时候：
        // collectionView.frame.sizew.width = 414（对应iPX的宽度）；而不是iP8的宽度375
        // 但是最外层的view的宽度就是准确的...
        let cellNumPerLine: CGFloat = UIDevice().model == "iPad" ? 4 : 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let space: CGFloat = 8
        let width = (view.frame.size.width - space * (cellNumPerLine + 1)) / cellNumPerLine
        let height = width * IconCell.ratio
        layout.itemSize = CGSize(width: Int(width), height: Int(height))  // 最后设置宽和高的时候要取整抹零，不然零点几的宽度差会把cell挤到下一行
    }
}

extension AchievementDetailVC: UICollectionViewDelegate, UICollectionViewDataSource  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        let icon = UIImage(named: recordList[indexPath.row].imgName)
        let text = TimeTool.minuteFormat(of: recordList[indexPath.row].minute)
        cell.drawCell(icon: icon, text: text)
        return cell
    }
}
