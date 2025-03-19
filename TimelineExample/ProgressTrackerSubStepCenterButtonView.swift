//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays a sub-step that centers a timeline icon with an action button.
///
/// This view is used for sub-steps where a centered call-to-action button (for example, "Pay $100.00")
/// is required. The timeline icon is centered vertically in its container.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)

public struct ProgressTrackerSubStepCenterButtonView: View {
    let buttonLabel: String
    let stepIndicator: StepIndicator
    let showDivider: Bool

    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Centered timeline icon view.
                ProgressTrackerTimelineView(stepIndicator: stepIndicator, timelinePosition: .middle)
                Spacer(minLength: 16)
                Button(buttonLabel) {
                    // Handle button action.
                }
                Spacer(minLength: 16)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
