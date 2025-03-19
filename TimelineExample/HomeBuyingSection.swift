//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays the "Home Loan Application" section of the Progress Tracker.
///
/// This section presents the steps involved in a home loan application:
/// 1. **Complete** – A non-expandable step.
/// 2. **Application Details** – An expandable step that shows sub-steps when expanded.
/// 3. **Your Property** – A non-expandable step.
/// 4. **Loan Details** – A non-expandable step.
///
/// When the "Application Details" step is tapped, it toggles the expansion state and reveals additional sub-steps.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)

struct HomeBuyingSection: View {
    // MARK: - Environment & Bindings
    /// Binding to control whether the "Application Details" sub-steps are shown.
    @Binding var applicationDetailsExpanded: Bool
    
    let dimensions = Dimensions()
    
    struct Dimensions {
        let spacingContainerVertical: CGFloat = 0
        // arcopo make this spacing 0
        let spacing300: CGFloat = 30
        let spacing200: CGFloat = 20
    }

    // MARK: - Body

    var body: some View {

        VStack(alignment: .leading, spacing: dimensions.spacingContainerVertical) {
            // Section title.
            Text("Home Loan Application")
                .font(.subheadline)
                .padding(.horizontal, dimensions.spacing300)
                .padding(.top, dimensions.spacing200)


            // Step 1: "Complete" (non-expandable).
            ProgressTrackerStepView(
                heading: "Complete",
                caption: nil,
                bodyContent: nil,
                sideLabel: nil,
                stepIndicator: .complete,
                timelinePosition: .first,
                expandState: .notExpandable,
                showDivider: true,
                onTap: {
                    
                }
            )

            // Step 2: "Application Details" (expandable).
            ProgressTrackerStepView(
                heading: "Application Details",
                caption: nil,
                bodyContent: nil,
                sideLabel: nil,
                stepIndicator: .complete,
                timelinePosition: .middle,
                expandState: applicationDetailsExpanded ? .expanded : .collapsed,
                showDivider: !applicationDetailsExpanded,
                onTap: { applicationDetailsExpanded.toggle() } // Toggle the expansion state when tapped.
            )

            // If expanded, show sub-steps.
            if applicationDetailsExpanded {
                ProgressTrackerSubStepView(
                    heading: "Borrowing Details",
                    caption: nil,
                    bodyContent: "This loan is for Sam Smith & Lisa Grey. Amount is $990,000",
                    stepIndicator: .complete,
                    showDivider: false
                )
                ProgressTrackerSubStepView(
                    heading: "Identification & consent",
                    caption: nil,
                    bodyContent: "We need to verify your identity and get consent to continue",
                    stepIndicator: .complete,
                    showDivider: false
                )
                ProgressTrackerSubStepView(
                    heading: "Proof of income",
                    caption: nil,
                    bodyContent: "We'll need some documents to prove your regular expenses",
                    stepIndicator: .substepComplete,
                    actionLabel: "Provide documents",
                    showDivider: false
                )
                ProgressTrackerSubStepView(
                    heading: "Savings & commitments",
                    caption: nil,
                    bodyContent: "We'll need some documents to prove your income",
                    stepIndicator: .complete,
                    showDivider: true
                )
            }
            
            ProgressTrackerSubStepCenterButtonView(buttonLabel: "Invoice", stepIndicator: .substepComplete, showDivider: false)

            // Step 3: "Your Property" (non-expandable).
            ProgressTrackerStepView(
                heading: "Your Property",
                caption: nil,
                bodyContent: nil,
                sideLabel: nil,
                stepIndicator: .complete,
                timelinePosition: .middle,
                expandState: .notExpandable,
                showDivider: true
            )

            // Step 4: "Loan Details" (non-expandable).
            ProgressTrackerStepView(
                heading: "Loan Details",
                caption: nil,
                bodyContent: nil,
                sideLabel: nil,
                stepIndicator: .complete,
                timelinePosition: .last,
                expandState: .notExpandable,
                showDivider: false
            )
        }
        .padding(.bottom, dimensions.spacing300)
    }
}


#Preview {
    @Previewable @State var expanded = false
    HomeBuyingSection(applicationDetailsExpanded: $expanded)
}
