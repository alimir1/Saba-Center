//
//  SabaCenterTests.swift
//  SabaCenterTests
//
//  Created by Ali Mir on 11/19/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import XCTest
@testable import Saba_Center

class SabaCenterTests: XCTestCase {
    
    var residentAlimVC: ResidentAlimViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        residentAlimVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "residentAlimVC") as! ResidentAlimViewController
        _ = residentAlimVC.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConstraint() {
        residentAlimVC.textForLabel = "Syed Nabi Raza Abidi was born and raised in Alipur, Karnataka (India) into a religious, Syed family from both parents. After completing his early education at the age of 14, he moved to Iran to pursue further Islamic studies.\n\nHe spent the first 2 years learning Farsi, Arabic grammar, and Ahkam in Najafabad, Isfahan, and then relocated to Qom for approximately 13 years.\n\nIn Qom, he studied at renowned Islamic seminaries and institutes such as the Institute of Imam Jafar as-Sadiq under the guidance of Ayatollah Jafar Subhani while concurrently earning his PhD in Theology and Philosophy from a sister school at the University of Tehran.\n\nUpon completing his lower level studies, he began his higher hawzah education, Dars al-Kharij, under many reputable scholars, such as Ayatollah Fadhel Lankarani, Ayatullah Bahjat, and Ayatollah Jafer Subhani.\n\nAfter completing his studies in 1999, he returned to India and taught at the University of Alighar while simultaneously serving and helping different communities. He also conducted business in Dubai, and then moved to Japan in 2000, where he established a business and helped develop a community and Islamic center.\n\nIn 2002, Syed Abidi moved to San Jose, CA to serve as the Resident A'lim of SABA Islamic Center, and has done so for the past 14+ years. Under his guidance and the dedicated help of the community, SABA has progressed significantly in these years, including the opening of a full-time school and the development of educational curricula.\n\nDuring his time in the Bay Area, he has participated in many interfaith and intrafaith events, spearheaded projects for the underprivileged, and played an integral role in the education realm. He also delivers lectures at churches and mosques throughout the country and advises several local and out of state mosques and Islamic community centers.\n\nHe continues to further his studies through research and occasional classes."
        print("constraint 3: \(residentAlimVC.viewHeightConstraint.constant)")
    }
    
}
