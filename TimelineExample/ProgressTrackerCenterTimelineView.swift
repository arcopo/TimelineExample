//  Copyright (c) 2025 Commonwealth Bank. All rights reserved.

import SwiftUI

/// Displays a centered timeline variant for sub-steps.
///
/// This view centers the timeline icon vertically, with dashed lines above and below,
/// which is particularly useful for sub-steps where the icon should be aligned to the center.
///
/// [Figma reference](https://www.figma.com/design/d5nxem1piXkREvJcLmvUdL/%F0%9F%9A%A7-Progress-Tracker-(Web-%2B-App)?node-id=2227-29078&p=f&t=xcxMNS4QrRpGCqus-0)

struct ProgressTrackerCenterTimelineView: View {
    let stepIndicator: StepIndicator

    var body: some View {
        VStack {
            Spacer()
            stepIndicator.image
                .padding(.vertical, 4)
            Spacer()
        }
        .frame(width: 30)
        .overlay(
            Rectangle()
                .fill(Color.secondary)
                .overlay(DashPatternOverlay())
        )
    }
}
#Preview {
    ProgressTrackerCenterTimelineView(stepIndicator: .complete)
}
