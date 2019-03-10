//
//  BundleExtension.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/10.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

class BundleEx: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.getLanguageBundel() {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}


extension Bundle {
    private static var onLanguageDispatchOnce: () -> Void = {
        /*
         原有的注释：替换Bundle.main为自定义的BundleEx
         
         个人理解：
         BundleEx.self是Bundle.Type类型——元类型，BundleEx.self包含了BundleEx类的全部信息
         https://juejin.im/post/5bfc0c096fb9a04a027a085b
         将Bundle.main设置成BundleEx类型，也就是说修改它的类信息（指修改“类的方法实现”等静态的信息）
         如cjd之前说的，“整个method的全部信息”是保存在类的静态区域的，和一些static变量一样
         修改了Bundle.main这个instance的静态区域，也就修改了Bundle.main的行为，但是没有干涉instance本身的数据（如它加载的资源）
         修改静态区域的说法可能不合适，更像是指针指向了新的类的静态区域（BundleEx的静态区域）？
         以上纯属推测，好像对了？（看下面）
         
         别忘了Objective-C的一个关键点：object内部有一个叫做isa的变量指向它的class。
         这个变量可以被改变，而不需要重新创建。然后就可以添加新的ivar和方法了。
         可以通过以下命令来修改一个object的class：  object_setClass(myObject, [MySubclass class]);
         这可以用在Key Value Observing。当你开始observing an object时，Cocoa会创建这个object的class的subclass，
         然后将这个object的isa指向新创建的subclass。
         https://limboy.me/tech/2013/08/03/dynamic-tips-and-tricks-with-objective-c.html
         */
        object_setClass(Bundle.main, BundleEx.self)
    }
    
    func onLanguage(){
        Bundle.onLanguageDispatchOnce()
    }
    
    class func getLanguageBundel() -> Bundle? {
        let languageName = (UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray).firstObject as! String
        let languageBundlePath = Bundle.main.path(forResource: languageName, ofType: "lproj")
        guard languageBundlePath != nil else {
            return nil
        }
        let languageBundle = Bundle.init(path: languageBundlePath!)
        guard languageBundle != nil else {
            return nil
        }
        return languageBundle!
    }
}
