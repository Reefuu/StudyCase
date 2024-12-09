import SwiftUI

struct ContentView: View {
    @StateObject var jobViewModel = JobViewModel()
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    Image("klobicon")
                        .imageScale(.medium)
                    Spacer()
                    NavigationLink(destination: AppliedJobsView(jobViewModel: jobViewModel)) {
                        Text("View Applied Jobs")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                Spacer()
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(jobViewModel.job ?? []) { job in
                            HStack {
                                AsyncImage(url: URL(string: job.corporateLogo)) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                
                                VStack(alignment: .leading) {
                                    Text(job.positionName)
                                        .font(.callout)
                                    Text(job.corporateName)
                                        .font(.caption)
                                    Text(job.status.rawValue)
                                        .font(.caption)
                                    Text(timeAgo(from: job.postedDate))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                VStack{
                                    Spacer()
                                    Group{
                                        if(!(job.salaryFrom == 0 && job.salaryTo == 0)){
                                            Text("IDR \(job.salaryFrom)\n - \(job.salaryTo)")
                                                .font(.caption)
                                                .padding(.trailing)
                                        }
                                        Button(action: {
                                            jobViewModel.applyForJob(id: job.id)
                                        }){
                                            Text(job.applied == true ? "Applied" : "Lamar")
                                                .foregroundColor(job.applied == true ? .gray : .blue)
                                        }
                                        .buttonStyle(.bordered)
                                        .padding(.trailing)
                                    }
                                }
                                .padding(.trailing)
                            }
                            .background(Color(.white))
                            
                            
                        }
                    }
                }
                Spacer()
                
            }
            .padding()
            .onAppear {
                Task {
                    do {
                        if jobViewModel.job == nil{
                            await jobViewModel.fetchJob()
                        }
                    }
                }
            }
        }
        ZStack{
            VStack(alignment: .center){
                Image("logo-footer-klob-white")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                Text("Copyright © 2024 PT DAYA5 REKRUTMEN.")
                    .foregroundColor(.white)
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .background(Color(.blue))
        }
    }
    
    func timeAgo(from dateString: String?) -> String {
        guard let dateString = dateString, let postedDate = dateFormatter().date(from: dateString) else {
            return ""
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.year, .month, .day], from: postedDate, to: now)
        
        if let year = components.year, year > 0 {
            return "\(year) year\(year > 1 ? "s" : "") ago"
        } else if let month = components.month, month > 0 {
            return "\(month) month\(month > 1 ? "s" : "") ago"
        } else if let day = components.day, day > 0 {
            return "\(day) day\(day > 1 ? "s" : "") ago"
        } else {
            return "Just now"
        }
    }
    
    func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

#Preview {
    ContentView()
}
