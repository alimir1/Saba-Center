//
//  DisplayInfoModel.swift
//  Saba Center
//
//  Created by Ali Mir on 11/19/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

struct SabaInfo {
    struct Article {
        let title: String
        let description: String
    }
    
    struct Informations {
        static var residentAlim = Article(title: "Moulana Nabi Raza", description: "Syed Nabi Raza Abidi was born and raised in Alipur, Karnataka (India) into a religious, Syed family from both parents. After completing his early education at the age of 14, he moved to Iran to pursue further Islamic studies.\n\nHe spent the first 2 years learning Farsi, Arabic grammar, and Ahkam in Najafabad, Isfahan, and then relocated to Qom for approximately 13 years.\n\nIn Qom, he studied at renowned Islamic seminaries and institutes such as the Institute of Imam Jafar as-Sadiq under the guidance of Ayatollah Jafar Subhani while concurrently earning his PhD in Theology and Philosophy from a sister school at the University of Tehran.\n\nUpon completing his lower level studies, he began his higher hawzah education, Dars al-Kharij, under many reputable scholars, such as Ayatollah Fadhel Lankarani, Ayatullah Bahjat, and Ayatollah Jafer Subhani.\n\nAfter completing his studies in 1999, he returned to India and taught at the University of Alighar while simultaneously serving and helping different communities. He also conducted business in Dubai, and then moved to Japan in 2000, where he established a business and helped develop a community and Islamic center.\n\nIn 2002, Syed Abidi moved to San Jose, CA to serve as the Resident A'lim of SABA Islamic Center, and has done so for the past 14+ years. Under his guidance and the dedicated help of the community, SABA has progressed significantly in these years, including the opening of a full-time school and the development of educational curricula.\n\nDuring his time in the Bay Area, he has participated in many interfaith and intrafaith events, spearheaded projects for the underprivileged, and played an integral role in the education realm. He also delivers lectures at churches and mosques throughout the country and advises several local and out of state mosques and Islamic community centers.\n\nHe continues to further his studies through research and occasional classes.")
        
        static var history = Article(title: "History of Saba", description: "In the 1970's, organized Shia Religious activities were almost non-existent in the Bay Area. Even though quite a few Shia families resided here at that time, yet no one had taken the initiative to do a search and somehow bring them together to form a Shia Community.\n\nIn 1977 a couple of families  took the initiative of locating the whereabouts of the Shia families and organizing a Moharram Majalis at their residences in San Jose. As the number of families attending these Majalis grew, the Majalis began to be held at other participants' residences too and some organizational difficulties and problems started to surface. This was the first time when the need for an Organization was recognized by the community.\n\nIn 1979 after the conclusion of a Majlis the Shia Association of Bay Area was formed and the people present at that time nominated five lifetime Trustees of the Association. The Association evolved from its' infancy in 1979 to a reasonably well organized community.\n\nAttendance increased a lot during Ramadhan for Iftar, Dua and Moharram programs. Instead of five lifetime Trustees, the Association decided to elect nine Trustees for two years. These Trustees perform various operating tasks voluntarily. A house was purchased in the city of San Jose in June of 1986 for $ 125,000.00 and converted into Hussaini Center. However, a permit to operate as a religious center could not be obtained due to strict requirements by the city.\n\nIn 1992 and as as the community grew and more and more families started to participate in religious gatherings, a 2500 square feet building at South White Road was purchased at a cost of $450,000.00. With the help of contributions from the community members, the building was paid off in a few years.\n\nIn mid 2000s under the guidance of Moulana Nabi Raza Abid, Saba purchased a building in San Jose, CA. Saba has since expanded and continues to expand with the grace of Allah SWT.")
    }
}


extension SabaInfo.Article {
    var attributedString: NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.5
        
        let pageTitleAttributes = [NSForegroundColorAttributeName: UIColor.gray]
        let pageDescriptionAttributes = [NSParagraphStyleAttributeName : paragraphStyle]
        
        let pageTitleText = NSMutableAttributedString(string: "\(title)\n\n", attributes: pageTitleAttributes)
        let pageDescriptionText = NSAttributedString(string: description, attributes: pageDescriptionAttributes)
        
        pageTitleText.append(pageDescriptionText)
        
        return pageTitleText
    }
}
