//
//  AchievementDetailVC.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/18.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit

class AchievementDetailVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var year: Int!
    var month: Int!
    var recordsOfDay = Dictionary<Int, [PlantRecord]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITool.setBackgroundImage(view, random: false)
        for record in PlantRecord.loadRecords(year: year, month: month) {
            if recordsOfDay.keys.contains(record.day) {
                recordsOfDay[record.day]?.append(record)
            } else {
                recordsOfDay[record.day] = [record]
            }
        }
        print(recordsOfDay)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        setCollectionLayout()
        setTitle()
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
    
    // 返回Section的数量
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recordsOfDay.keys.count
    }
    
    // 返回每个Section中cell的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let keyArray = Array(recordsOfDay.keys)
        return recordsOfDay[keyArray[section]]!.count
    }
    
    // 返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        let day = Array(recordsOfDay.keys)[indexPath.section]
        let record = recordsOfDay[day]![indexPath.item]
        let icon = UIImage(named: record.imgName)
        let text = "\(record.minute)\(LocalizationKey.Minute.translate())"
        cell.drawCell(icon: icon, text: text)
        return cell
    }
    
    // 返回自定义的header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview:UICollectionReusableView!
        
        //分区头
        if kind == UICollectionView.elementKindSectionHeader{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DateHeader", for: indexPath)
            //设置头部标题
//            let label = reusableview.viewWithTag(1) as! UILabel
//            label.text = "2333333"
        }
        //分区尾
        else if kind == UICollectionView.elementKindSectionFooter{
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: "DateFooter", for: indexPath)
        }
        return reusableview
    }
}
