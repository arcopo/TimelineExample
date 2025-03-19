//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays a sub-step within a progress tracker step.
///
/// This view renders sub-step information with a smaller text style.
/// It includes a timeline icon, a heading (and optionally caption/body),
/// and can optionally include an action button. It also supports showing a side label,
/// with a special style for refund scenarios.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)

public struct ProgressTrackerSubStepView: View {
    // MARK: - Properties

    let heading: String
    let caption: String?
    let bodyContent: String?
    var sideLabel: String? = nil
    let stepIndicator: StepIndicator
    var actionLabel: String? = nil
    let showDivider: Bool

    @State private var headingHeight: CGFloat = 0 // Track height

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                // Sub-step timeline (always middle).
                ProgressTrackerTimelineView(
                    stepIndicator: stepIndicator,
                    timelinePosition: .middle,
                    headingHeight: $headingHeight
                )
                // Text block for sub-step.
                VStack(alignment: .leading, spacing: 8) {
                    TextHeightReader(text: heading, font: .body, height: $headingHeight) // Measure height
                        .accessibilityAddTraits(.isHeader)
                    if let c = caption {
                        Text(c)
                            .fontWeight(.thin)
                            .font(.caption)
                    }
                    if let b = bodyContent {
                        Text(b)
                            .font(.body)
                            .foregroundStyle(Color.gray)
                    }
                    // Optional action button.
                    if let buttonLabel = actionLabel {
                        Button(action: {
                            // action here
                        }, label: {
                            Text(buttonLabel)
                        })
                        .padding(.top, 12)
                    }
                    if showDivider {
                        Rectangle()
                            .frame(width: .infinity, height: 1, alignment: .leading)
                            .foregroundStyle(Color.gray.opacity(0.2))
                    }
                }
                .padding(.vertical) // arcopo add the vertical padding here
                .frame(maxWidth: .infinity, alignment: .leading)
                // Optional side label.
                if let label = sideLabel {
                    Text(label)
                        .font(.body)
                        .foregroundColor(true ? .green : .primary) // Will update to appropriate Lumen color
                }
            }
            .padding(.horizontal)
            .background(Color.clear)
            //.padding(.vertical, 8)
            // arcopo remove this vertical padding
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        ProgressTrackerSubStepView(
            heading: "Borrowing Details",
            caption: nil,
            bodyContent: "This loan is for Sam Smith & Lisa Grey. Amount is $990,000",
            stepIndicator: .complete,
            showDivider: true
        )
        ProgressTrackerSubStepView(
            heading: "Borrowing Details",
            caption: nil,
            bodyContent: "This loan is for Sam Smith & Lisa Grey. Amount is $990,000",
            stepIndicator: .complete,
            showDivider: false
        )
    }
}
