//
//  LegendView.swift
//  LegendStory
//
//  Created by Mattia Golino on 03/04/23.
//

import SwiftUI

struct LegendView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Binding var listOfLegend: MetropolitanLegends?
    @Binding var insertTag: String
    @Binding var suggestedTag: [String:Any]
    
    var body: some View {
        if(listOfLegend != nil){
            ZStack{
                Image("Book").resizable()
                VStack(spacing: 10){
                    VStack(spacing: 5){
                        Text(listOfLegend!.legendName!).font(.title)
                        Text(listOfLegend!.legendLocation!).multilineTextAlignment(.center).font(.callout)
                    }
                    ScrollView(.vertical, showsIndicators: false){
                        Text(listOfLegend!.legenDescription!).multilineTextAlignment(.leading).frame(width: 340)
                    }.frame(maxHeight: 500)
                    VStack{
                        Text("Did you like this story then look also for:")
                        Text(suggestedTag.keys.randomElement()!).font(.title)
                        
                    }
                }
            }.onDisappear(){
                DataController().isReadLegend(aLegend: listOfLegend!, aContext: managedObjContext)
            }
        }else{
            ZStack{
                Image("Book").resizable()
                VStack{
                    Text("No legend found, try again with:")
                    Text(suggestedTag.keys.randomElement()!).font(.title)
                }
            }
        }
    }
}
