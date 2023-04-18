//
//  LegendView.swift
//  LegendStory
//
//  Created by Mattia Golino on 03/04/23.
//

import SwiftUI

struct LegendView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.presentationMode) var presentationMode
    @Binding var listOfLegend: MetropolitanLegends?
    @Binding var insertTag: String
    @Binding var suggestedTag: [String:Any]
    
    var body: some View {
        if(UIDevice.current.userInterfaceIdiom == .phone){
            if(listOfLegend != nil){
                ZStack{
                    Image("Book").resizable()
                    VStack(spacing: 10){
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Label("Back", image: "chevron.backward")
                        }
                        VStack(spacing: 5){
                            Text(listOfLegend!.legendName!).font(.title)
                            Text(listOfLegend!.legendLocation!).multilineTextAlignment(.center).font(.callout)
                        }
                        ScrollView(.vertical, showsIndicators: false){
                            Text(listOfLegend!.legenDescription!).multilineTextAlignment(.leading).lineLimit(/*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/).frame(width: 340)
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
        }else if(UIDevice.current.userInterfaceIdiom == .pad){
            if(listOfLegend != nil){
                ZStack{
                    Image("Book").resizable()
                    VStack{
                        Spacer()
                        Spacer()
                        HStack{
                            Spacer().frame(width: 50)
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Label("Back", systemImage: "chevron.backward")
                            }
                            Spacer()
                            Spacer()
                        }
                        Spacer().frame(height: 50)
                        HStack(spacing: 50){
                            Image(listOfLegend!.legendImage).resizable().frame(width: 250,height: 250)
                            Spacer().frame(width: 100)
                            VStack(spacing: 10){
                                Text(listOfLegend!.legendName!).font(.largeTitle)
                                Text(listOfLegend!.legendLocation!).multilineTextAlignment(.center).font(.headline)
                            }
                        }
                        Spacer()
                        ScrollView(.vertical, showsIndicators: false){
                            Text(listOfLegend!.legenDescription!).font(.title3).multilineTextAlignment(.leading).frame(width: 650).lineSpacing(/*@START_MENU_TOKEN@*/7.0/*@END_MENU_TOKEN@*/)
                        }.frame(maxHeight: 600)
                        Spacer()
                        VStack{
                            Text("Did you like this story then look also for:")
                                .font(.title2)
                            Text(suggestedTag.keys.randomElement()!).font(.title)
                            
                        }
                        Spacer()
                    }
                }.onDisappear(){
                    DataController().isReadLegend(aLegend: listOfLegend!, aContext: managedObjContext)
                }
            }else{
                ZStack{
                    Image("Book").resizable()
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Label("Back", systemImage: "chevron.backward")
                            }
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    VStack{
                        Text("No legend found, try again with:")
                        Text(suggestedTag.keys.randomElement()!).font(.title)
                    }
                }
            }
        }
    }
}
