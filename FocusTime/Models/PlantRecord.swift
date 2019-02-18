//
//  PlantRecord.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/15.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import UIKit
import os.log


class PlantRecord: NSObject, NSCoding {
    
    //MARK: Properties
    var imgName: String
    var minute: Int
    var year: Int
    var month: Int
    var day: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PlantRecords")
    static let RecordFile = "Records"
    static let TimeFile = "TotalTime"
    
    //MARK: Types
    
    struct PropertyKey {
        static let imgName = "imgName"
        static let minute = "minute"
        static let year = "year"
        static let month = "month"
        static let day = "day"
    }
    
    //MARK: Initialization
    
    init?(imgName: String, minute: Int, year: Int, month: Int, day: Int) {
        guard !imgName.isEmpty else { return nil }
        guard minute > 0 else { return nil }
        guard year > 0 else { return nil }
        guard (month > 0) && (month <= 12) else { return nil }
        guard (day > 0) && (day <= 31) else { return nil }
        
        self.imgName = imgName
        self.minute = minute
        self.year = year
        self.month = month
        self.day = day
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imgName, forKey: PropertyKey.imgName)
        aCoder.encode(minute, forKey: PropertyKey.minute)
        aCoder.encode(year, forKey: PropertyKey.year)
        aCoder.encode(month, forKey: PropertyKey.month)
        aCoder.encode(day, forKey: PropertyKey.day)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let imgName = aDecoder.decodeObject(forKey: PropertyKey.imgName) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let minute = aDecoder.decodeInteger(forKey: PropertyKey.minute)
        let year = aDecoder.decodeInteger(forKey: PropertyKey.year)
        let month = aDecoder.decodeInteger(forKey: PropertyKey.month)
        let day = aDecoder.decodeInteger(forKey: PropertyKey.day)
        self.init(imgName: imgName, minute: minute, year: year, month: month, day: day)
    }
}

extension PlantRecord {
    
    func save() {
        saveRecords()
        updateTotalTime()
    }
    
    private func saveRecords() {
        do {
            var records = PlantRecord.loadRecords(year: year, month: month)
            records.append(self)
            let fileURL = PlantRecord.getDirectory(year: year, month: month).appendingPathComponent(PlantRecord.RecordFile)
            let data = try NSKeyedArchiver.archivedData(withRootObject: records, requiringSecureCoding: false)
            try data.write(to: fileURL)
        } catch {
            return
        }
    }
    
    private func updateTotalTime() {
        do {
            let totalTime = PlantRecord.loadTotalTime(year: year, month: month) + minute
            let fileURL = PlantRecord.getDirectory(year: year, month: month).appendingPathComponent(PlantRecord.TimeFile)
            let data = try NSKeyedArchiver.archivedData(withRootObject: totalTime, requiringSecureCoding: false)
            try data.write(to: fileURL)
        } catch {
            return
        }
    }
    
    static func loadRecords(year: Int, month: Int) -> [PlantRecord] {
        do {
            let fileURL = PlantRecord.getDirectory(year: year, month: month).appendingPathComponent(PlantRecord.RecordFile)
            let fileData = try Data(contentsOf: fileURL)
            let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData)
            return result as! [PlantRecord]
        } catch {
            return []
        }
    }
    
    static func loadTotalTime(year: Int, month: Int) -> Int {
        do {
            let fileURL = PlantRecord.getDirectory(year: year, month: month).appendingPathComponent(PlantRecord.TimeFile)
            let fileData = try Data(contentsOf: fileURL)
            let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fileData)
            return result as! Int
        } catch {
            return 0
        }
    }
    
    static func getDirectory(year: Int, month: Int) -> URL {
        let url = PlantRecord.ArchiveURL.appendingPathComponent("\(year)").appendingPathComponent("\(month)")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: url.path) {
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return url
    }
    
    static func getRecordYears() -> [Int] {
        do {
            let fileManager = FileManager.default
            let years = try fileManager.contentsOfDirectory(atPath: PlantRecord.ArchiveURL.path)
            let result = years.map { year -> Int in return Int(year) ?? TimeTool.getCurrentYear()}
            return result.count > 0 ? result : [TimeTool.getCurrentYear()]
        } catch {
            return [TimeTool.getCurrentYear()]
        }
    }
}
