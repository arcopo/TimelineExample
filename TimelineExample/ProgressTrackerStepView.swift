//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays a single progress tracker step.
///
/// This view is responsible for showing a step with:
/// - A timeline icon (via `ProgressTrackerTimelineView`).
/// - A heading, optional caption, and body text.
/// - An optional side label (such as a monetary amount).
/// - An optional expand/collapse chevron if the step is expandable.
///
/// Tapping the step triggers an optional tap action (used to expand or collapse the step).
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)

enum ProgressStepExpandState {
    case expanded
    case notExpandable
    case collapsed
}

enum TimelinePosition{
    case first
    case middle
    case last
    case none
}

enum StepIndicator {
    var image: Image {
        return .init(systemName: "checkmark.circle.fill")
    }
    case complete
    case substepComplete
}

public struct ProgressTrackerStepView: View {
    // MARK: - Properties

    let heading: String
    let caption: String?
    let bodyContent: String?
    let sideLabel: String?
    let stepIndicator: StepIndicator
    let timelinePosition: TimelinePosition
    let expandState: ProgressStepExpandState
    let showDivider: Bool
    var onTap: (() -> Void)? = nil

    @State private var headingHeight: CGFloat = 0 // Track height

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                // Timeline view with dashed line and icon.
                ProgressTrackerTimelineView(
                    stepIndicator: stepIndicator,
                    timelinePosition: timelinePosition,
                    headingHeight: $headingHeight
                )
                // Main text block (heading, caption, body).
                VStack(spacing: 0) {
                    HStack(alignment: .center) { // arcopo put it in this extra hstack
                        VStack(alignment: .leading, spacing: 8) {
                            TextHeightReader(text: heading, font: .title, height: $headingHeight) // Measure height
                                .accessibilityAddTraits(.isHeader)
      
                            if let c = caption {
                                Text(c)
                                    .font(.caption)
                            }
                            if let b = bodyContent {
                                Text(b)
                                    .font(.body)
                            }
                        }
                        .padding(.vertical) // arcopo add the vertical padding here
                        .frame(maxWidth: .infinity, alignment: .leading)
                        // Side label (e.g., monetary value).
                        if let label = sideLabel {
                            Text(label)
                                .font(.body)
                                .frame(alignment: .trailing)
                        }
                        // Chevron for expandable steps.
                        if expandState != .notExpandable {
                            Image(uiImage: expandState == .expanded ? .init(systemName: "chevron.up")! : .init(systemName: "chevron.down")!)
                                .padding(.leading, 8)
                        }
                    }
                    if showDivider {
                        Rectangle()
                            .frame(width: .infinity, height: 1, alignment: .leading)
                            .foregroundStyle(Color.gray.opacity(0.2))
                    }
                }
                
            }
            // arcopo make this just horizontal
            .padding(.horizontal)
            .contentShape(Rectangle())
            .onTapGesture { onTap?() }
            .background(Color.clear)
        }.background(Color.clear)
    }
}

#Preview {
    ProgressTrackerStepView(
        heading: "Complete",
        caption: nil,
        bodyContent: nil,
        sideLabel: nil,
        stepIndicator: .complete,
        timelinePosition: .first,
        expandState: .expanded,
        showDivider: true
    )
}
