//
//  User.swift
//  RealmTest
//
//  Created by Diana on 26.09.2022.
//

import Foundation
import RealmSwift

class Person: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
    @Persisted var interests: String = ""
}
