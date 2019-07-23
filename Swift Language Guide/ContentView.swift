//
//  ContentView.swift
//  Swift Language Guide
//
//  Created by 新井進鎬 on 2019/07/23.
//  Copyright © 2019 chino. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
