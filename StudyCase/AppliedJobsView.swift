import SwiftUI

struct AppliedJobsView: View {
    @ObservedObject var jobViewModel: JobViewModel

    var body: some View {
        VStack {
            if let appliedJobs = jobViewModel.job?.filter({ $0.applied == true }), appliedJobs.isEmpty {
                Text("Belum ada lowongan terkirim")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(jobViewModel.job?.filter({ $0.applied == true }) ?? []) { job in
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
                            }
                            .background(Color(.white))
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Applied Jobs")
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
    AppliedJobsView(jobViewModel: JobViewModel())
}
