import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \MetropolitanLegends.legendIndex, ascending: true)], animation: .default)
    private var aLegends: FetchedResults<MetropolitanLegends>
    @State var Desc: String = ""
    @State var isPresentingScene: Bool = false
    @State var possibleLegendShow: [MetropolitanLegends] = Array()
    @State var legendForTag: [MetropolitanLegends] = Array()
    @State var legendChoose: MetropolitanLegends?
    @State var Tag: [String:Any] = [:]
    
    var body: some View {
        ZStack{
            Image("Background").resizable(resizingMode: .stretch).ignoresSafeArea()
            VStack{
                TextField("", text: self.$Desc,prompt: Text("Enter a tag as 'Mystery' to search the legend ").foregroundColor(.white)).padding().foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray,lineWidth: 2))
                HStack{
                    Button {
                        possibleLegendShow = filterByLegendTag(legends: aLegends, inserTag: Desc)
                        legendChoose = possibleLegendShow.isEmpty ? nil : possibleLegendShow.randomElement()!
                        isPresentingScene.toggle()
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 140, height: 65).foregroundColor(.blue)
                            Text("Search").foregroundColor(.white)
                        }.padding()
                    }.fullScreenCover(isPresented: $isPresentingScene) {
                        LegendView(listOfLegend: $legendChoose, insertTag: $Desc, suggestedTag: $Tag)
                    }
                    Button {
                        Desc = Tag.keys.randomElement()!
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 20).frame(width: 140, height: 65).foregroundColor(.blue)
                            Text("Random tag").foregroundColor(.white)
                        }.padding()
                    }

                }
            }
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                if(!UserDefaults.standard.bool(forKey: "firsTime")){
                    legendForTag = DataController().getLegends(aContext: managedObjContext)
                    Tag = bestTag(legends: legendForTag)
                    UserDefaults.standard.set(Tag, forKey: "Tag")
                    UserDefaults.standard.set(true,forKey: "firsTime")
                }else{
                    Tag = UserDefaults.standard.dictionary(forKey: "Tag")!
                }
            }
        }
    }
    
    func filterByLegendTag(legends: FetchedResults<MetropolitanLegends>, inserTag: String) -> [MetropolitanLegends]{
        var tmp: [MetropolitanLegends] = Array()
        if(inserTag.compare("", options: .caseInsensitive) != .orderedSame){
            for legend in legends {
                let tmpTag = legend.legendTag!.components(separatedBy: ",")
                for tag in tmpTag {
                    if(tag.compare(inserTag, options: .caseInsensitive) == .orderedSame && !(legend.legendIsRead)){
                        tmp.append(legend)
                    }
                }
            }
        }
        return tmp
    }
    
    func bestTag(legends: [MetropolitanLegends]) -> [String:Int]{
        var tmp: [String:Int] = Dictionary()
        for thisLegend in legends {
            let tagList = thisLegend.legendTag!.components(separatedBy: ",")
            for thisTag in tagList{
                for otherLegend in legends{
                    let listOfTag = otherLegend.legendTag!.components(separatedBy: ",")
                    var count = 0
                    for otherTag in listOfTag{
                        if(otherLegend.legendName!.compare(thisLegend.legendName!, options: .caseInsensitive) != .orderedSame){
                            if(otherTag.compare(thisTag, options: .caseInsensitive) == .orderedSame){
                                if(tmp.contains{$0.key.compare(otherTag, options: .caseInsensitive) == .orderedSame}){
                                    count+=1
                                    tmp.updateValue(count, forKey: otherTag)
                                }else{
                                    count+=1
                                    tmp[otherTag] = count
                                }
                            }
                        }
                    }
                }
            }
        }
        return tmp
    }
    
}
